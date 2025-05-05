package com.example.method_channel

import android.app.AlertDialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.widget.ProgressBar
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.native_loader"
    private var alertDialog: AlertDialog? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "showLoader" -> {
                    showLoader()
                    result.success(null)
                }
                "hideLoader" -> {
                    hideLoader()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun showLoader() {
        runOnUiThread {
            if (alertDialog == null) {
                val progressBar = ProgressBar(this)
                val builder = AlertDialog.Builder(this)
                builder.setView(progressBar)
                builder.setCancelable(false)
                alertDialog = builder.create()
            }
            alertDialog?.show()
        }
    }

    private fun hideLoader() {
        runOnUiThread {
            alertDialog?.dismiss()
            alertDialog = null
        }
    }
}
