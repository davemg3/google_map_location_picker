import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker/src/providers/location_provider.dart';
import 'package:google_map_location_picker/src/utils/loading_builder.dart';
import 'package:google_map_location_picker/src/utils/log.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../generated/app_localizations.dart';
import 'model/location_result.dart';
import 'utils/location_utils.dart';

class MapPicker extends StatefulWidget {
  const MapPicker(
    this.apiKey, {
    Key? key,
    this.initialCenter,
    this.initialZoom,
    this.requiredGPS,
    this.myLocationButtonEnabled,
    this.layersButtonEnabled,
    this.automaticallyAnimateToCurrentLocation,
    this.mapStylePath,
    this.appBarColor,
    this.searchBarBoxDecoration,
    this.hintText,
    this.resultCardConfirmIcon,
    this.resultCardAlignment,
    this.resultCardDecoration,
    this.resultCardPadding,
    this.language,
    this.desiredAccuracy,
    this.isCirle = false,
    this.circleRadius = 500,
    this.circleColor = Colors.yellow,
  }) : super(key: key);

  final String apiKey;

  final LatLng? initialCenter;
  final double? initialZoom;

  final bool? requiredGPS;
  final bool? myLocationButtonEnabled;
  final bool? layersButtonEnabled;
  final bool? automaticallyAnimateToCurrentLocation;

  final String? mapStylePath;

  final Color? appBarColor;
  final BoxDecoration? searchBarBoxDecoration;
  final String? hintText;
  final Widget? resultCardConfirmIcon;
  final Alignment? resultCardAlignment;
  final Decoration? resultCardDecoration;
  final EdgeInsets? resultCardPadding;

  final String? language;

  final LocationAccuracy? desiredAccuracy;
  final bool isCirle;
  final double circleRadius;
  final Color circleColor;

  @override
  MapPickerState createState() => MapPickerState();
}

class MapPickerState extends State<MapPicker> {
  Completer<GoogleMapController> mapController = Completer();

  MapType _currentMapType = MapType.normal;

  String? _mapStyle;

  LatLng? _lastMapPosition;

  Position? _currentPosition;

  String? _address;
  String? _placeId;
  String? _streetNumber;
  String? _route;
  String? _locality;
  String? _administrativeAreaLevel2;
  String? _administrativeAreaLevel1;
  String? _country;
  String? _postalCode;
  Timer? timer;
  Set<Circle> _circles = HashSet<Circle>();

  void _onToggleMapTypePressed() {
    final MapType nextType = MapType.values[(_currentMapType.index + 1) % MapType.values.length];

    setState(() => _currentMapType = nextType);
  }

  // this also checks for location permission.
  Future<void> _initCurrentLocation() async {
    Position? currentPosition;
    try {
      currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: widget.desiredAccuracy!);
      d("position = $currentPosition");

      setState(() => _currentPosition = currentPosition);
    } catch (e) {
      currentPosition = null;
      d("_initCurrentLocation#e = $e");
    }
    d("mounted# = $mounted");
    if (!mounted) return;

    setState(() => _currentPosition = currentPosition);

    if (currentPosition != null) moveToCurrentLocation(LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  Future moveToCurrentLocation(LatLng currentLocation) async {
    d('MapPickerState.moveToCurrentLocation "currentLocation = [$currentLocation]"');
    //db08/07/2024
    if (widget.isCirle) {
      _circles.clear();
      _circles.add(Circle(
          circleId: CircleId(UniqueKey().toString()),
          center: currentLocation,
          radius: widget.circleRadius,
          fillColor: widget.circleColor.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: widget.circleColor));
    }
    //
    final controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      //CameraPosition(target: currentLocation, zoom: 16),
      CameraPosition(target: currentLocation, zoom: widget.initialZoom!),
    ));
  }

  @override
  void initState() {
    super.initState();
    if (widget.automaticallyAnimateToCurrentLocation! && !widget.requiredGPS!) _initCurrentLocation();

    if (widget.mapStylePath != null) {
      rootBundle.loadString(widget.mapStylePath!).then((string) {
        _mapStyle = string;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.requiredGPS!) {
      _checkGeolocationPermission();
      if (_currentPosition == null) _initCurrentLocation();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    d("map build $_currentPosition initialZoom ${widget.initialZoom}");
/*
    if (widget.requiredGPS!) {
      _checkGeolocationPermission();
      if (_currentPosition == null) _initCurrentLocation(); //db : warning when null this creates un infinite loop
    }
*/

    if (_currentPosition != null && dialogOpen != null) Navigator.of(context, rootNavigator: true).pop();

    return Scaffold(
      body: Builder(
        builder: (context) {
          if (_currentPosition == null && widget.automaticallyAnimateToCurrentLocation! && widget.requiredGPS!) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildMap();
        },
      ),
    );
  }

  Widget buildMap() {
    return Center(
      child: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: widget.initialCenter!,
              zoom: widget.initialZoom!,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
              //Implementation of mapStyle
              if (widget.mapStylePath != null) {
                controller.setMapStyle(_mapStyle);
              }

              _lastMapPosition = widget.initialCenter;
              LocationProvider.of(context, listen: false).setLastIdleLocation(_lastMapPosition);
            },
            onCameraMove: (CameraPosition position) {
              _lastMapPosition = position.target;
            },
            onCameraIdle: () async {
              print("onCameraIdle#_lastMapPosition = $_lastMapPosition");
              timer = Timer(Duration(milliseconds: 500), () {
                //condition check to avoid calling server too often
                LocationProvider.of(context, listen: false).setLastIdleLocation(_lastMapPosition);
                setState(() {});
              });
            },
            onCameraMoveStarted: () {
              print("onCameraMoveStarted#_lastMapPosition = $_lastMapPosition");
            },
//            onTap: (latLng) {
//              clearOverlay();
//            },
            mapType: _currentMapType,
            myLocationEnabled: true,
            circles: _circles,
          ),
          _MapFabs(
            myLocationButtonEnabled: widget.myLocationButtonEnabled,
            layersButtonEnabled: widget.layersButtonEnabled,
            onToggleMapTypePressed: _onToggleMapTypePressed,
            onMyLocationPressed: _initCurrentLocation,
          ),
          pin(),
          locationCard(),
        ],
      ),
    );
  }

  Widget locationCard() {
    return Align(
      alignment: widget.resultCardAlignment ?? Alignment.bottomCenter,
      child: Padding(
        padding: widget.resultCardPadding ?? EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Consumer<LocationProvider>(builder: (context, locationProvider, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 20,
                    child: FutureLoadingBuilder<Map<String, String?>?>(
                      future: getAddress(locationProvider.lastIdleLocation),
                      mutable: true,
                      loadingIndicator: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                      builder: (context, data) {
                        if (data == null) {
                          return const SizedBox();
                        }
                        _address = data["address"];
                        _placeId = data["placeId"];
                        _streetNumber = data["streetNumber"];
                        _route = data["route"];
                        _locality = data["locality"];
                        _administrativeAreaLevel2 = data["administrativeAreaLevel2"];
                        _administrativeAreaLevel1 = data["administrativeAreaLevel1"];
                        _country = data["country"];
                        _postalCode = data["postalCode"];
                        return Text(
                          _address ?? AppLocalizations.of(context)?.unnamedPlace ?? '',
                          style: TextStyle(fontSize: 18),
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pop({
                        'location': LocationResult(
                          latLng: locationProvider.lastIdleLocation,
                          formattedAddress: _address,
                          placeId: _placeId,
                          streetNumber: _streetNumber,
                          route: _route,
                          locality: _locality,
                          administrativeAreaLevel2: _administrativeAreaLevel2,
                          administrativeAreaLevel1: _administrativeAreaLevel1,
                          country: _country,
                          postalCode: _postalCode,
                        )
                      });
                    },
                    child: widget.resultCardConfirmIcon ??
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<Map<String, String?>> getAddress(LatLng? location) async {
    try {
      final endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location?.latitude},${location?.longitude}'
          '&key=${widget.apiKey}&language=${widget.language}';

      final response = jsonDecode((await http.get(Uri.parse(endpoint), headers: await LocationUtils.getAppHeaders())).body);

      List<dynamic> addressComponents = response['results'][0]['address_components'];
      String? streetNumber;
      String? route;
      String? locality;
      String? administrativeAreaLevel2;
      String? administrativeAreaLevel1;
      String? country;
      String? postalCode;
      if (addressComponents != null) {
        streetNumber = addressComponents.firstWhere((entry) => entry['types'].contains('street_number'))['long_name'];
        route = addressComponents.firstWhere((entry) => entry['types'].contains('route'))['long_name'];
        locality = addressComponents.firstWhere((entry) => entry['types'].contains('locality'))['long_name'];
        administrativeAreaLevel2 =
            addressComponents.firstWhere((entry) => entry['types'].contains('administrative_area_level_2'))['long_name'];
        administrativeAreaLevel1 =
            addressComponents.firstWhere((entry) => entry['types'].contains('administrative_area_level_1'))['long_name'];
        country = addressComponents.firstWhere((entry) => entry['types'].contains('country'))['long_name'];
        postalCode = addressComponents.firstWhere((entry) => entry['types'].contains('postal_code'))['long_name'];
      }
      return {
        "placeId": response['results'][0]['place_id'],
        "address": response['results'][0]['formatted_address'],
        "streetNumber": streetNumber ?? '',
        "route": route ?? '',
        "locality": locality ?? '',
        "administrativeAreaLevel2": administrativeAreaLevel2 ?? '',
        "administrativeAreaLevel1": administrativeAreaLevel1 ?? '',
        "country": country ?? '',
        "postalCode": postalCode ?? '',
      };
    } catch (e) {
      print(e);
    }

    return {"placeId": null, "address": null};
  }

  Widget pin() {
    return IgnorePointer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.place,
              size: 56,
            ),
            Container(
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black38,
                  ),
                ],
                shape: CircleBorder(
                  side: BorderSide(
                    width: 4,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  var dialogOpen;

  Future _checkGeolocationPermission() async {
    final geolocationStatus = await Geolocator.checkPermission();
    d("geolocationStatus = $geolocationStatus");

    if (geolocationStatus == LocationPermission.denied && dialogOpen == null) {
      dialogOpen = _showDeniedDialog();
    } else if (geolocationStatus == LocationPermission.deniedForever && dialogOpen == null) {
      dialogOpen = _showDeniedForeverDialog();
    } else if (geolocationStatus == LocationPermission.whileInUse || geolocationStatus == LocationPermission.always) {
      d('GeolocationStatus.granted');

      if (dialogOpen != null) {
        Navigator.of(context, rootNavigator: true).pop();
        dialogOpen = null;
      }
    }
  }

  Future _showDeniedDialog() {
    d("_showDeniedDialog context ");
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
            return true;
          },
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.access_to_location_denied),
            content: Text(AppLocalizations.of(context)!.allow_access_to_the_location_services),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  _initCurrentLocation();
                  dialogOpen = null;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future _showDeniedForeverDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
            return true;
          },
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.access_to_location_permanently_denied),
            content: Text(AppLocalizations.of(context)!.allow_access_to_the_location_services_from_settings),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Geolocator.openAppSettings();
                  dialogOpen = null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MapFabs extends StatelessWidget {
  const _MapFabs({
    Key? key,
    required this.myLocationButtonEnabled,
    required this.layersButtonEnabled,
    required this.onToggleMapTypePressed,
    required this.onMyLocationPressed,
  }) : super(key: key);

  final bool? myLocationButtonEnabled;
  final bool? layersButtonEnabled;

  final VoidCallback onToggleMapTypePressed;
  final VoidCallback onMyLocationPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: kToolbarHeight + 24, right: 8),
      child: Column(
        children: <Widget>[
          if (layersButtonEnabled!)
            FloatingActionButton(
              onPressed: onToggleMapTypePressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              mini: true,
              child: const Icon(
                Icons.layers,
                color: Colors.white,
              ),
              heroTag: "layers",
            ),
          if (myLocationButtonEnabled!)
            FloatingActionButton(
              onPressed: onMyLocationPressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              mini: true,
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
              heroTag: "myLocation",
            ),
        ],
      ),
    );
  }
}
