package com.humazed.google_map_location_picker

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import android.content.pm.PackageManager
import java.math.BigInteger
import java.security.MessageDigest
import android.content.pm.PackageInfo

class GoogleMapLocationPickerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware  {
    private lateinit var channel : MethodChannel
    private var activityBinding: ActivityPluginBinding? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "google_map_location_picker")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if(activityBinding == null) {
            result.notImplemented()
            return
        }
        if (call.method == "getSigningCertSha1") {
            try {
                val info: PackageInfo
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.P) {
                    info = activityBinding!!.activity.packageManager.getPackageInfo(call.arguments<String>()!!, PackageManager.GET_SIGNING_CERTIFICATES)//26/01/204 added !! as error  inferred type is String?
                    for (signature in info.signingInfo.apkContentsSigners) {
                        val md: MessageDigest = MessageDigest.getInstance("SHA1")
                        md.update(signature.toByteArray())

                        val bytes: ByteArray = md.digest()
                        val bigInteger = BigInteger(1, bytes)
                        val hex: String = String.format("%0" + (bytes.size shl 1) + "x", bigInteger)

                        result.success(hex)
                    }
                } else {
                    @Suppress("DEPRECATION")
                    info = activityBinding!!.activity.packageManager.getPackageInfo(call.arguments<String>()!!, PackageManager.GET_SIGNATURES)//26/01/204 added !! as error  inferred type is String?
                    @Suppress("DEPRECATION")
                    for (signature in info.signatures) {
                        val md: MessageDigest = MessageDigest.getInstance("SHA1")
                        md.update(signature.toByteArray())

                        val bytes: ByteArray = md.digest()
                        val bigInteger = BigInteger(1, bytes)
                        val hex: String = String.format("%0" + (bytes.size shl 1) + "x", bigInteger)

                        result.success(hex)
                    }
                }


        /*        val info: PackageInfo = activityBinding!!.activity.packageManager.getPackageInfo(call.arguments<String>(), PackageManager.GET_SIGNATURES)

                for (signature in info.signatures) {
                    val md: MessageDigest = MessageDigest.getInstance("SHA1")
                    md.update(signature.toByteArray())

                    val bytes: ByteArray = md.digest()
                    val bigInteger = BigInteger(1, bytes)
                    val hex: String = String.format("%0" + (bytes.size shl 1) + "x", bigInteger)

                    result.success(hex)
                }*/
            } catch (e: Exception) {
                result.error("ERROR", e.toString(), null)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        // TODO: your plugin is now attached to an Activity
        activityBinding = binding
    }

    override fun onDetachedFromActivity() {
        // TODO: your plugin is no longer associated with an Activity.
        // Clean up references.
        activityBinding = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        // TODO: the Activity your plugin was attached to was
        // destroyed to change configuration.
        // This call will be followed by onReattachedToActivityForConfigChanges().
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        // TODO: your plugin is now attached to a new Activity
        // after a configuration change.
    }
}
