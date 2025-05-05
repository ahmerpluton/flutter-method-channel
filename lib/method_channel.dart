import 'package:flutter/services.dart';

class NativeLoader {
  static const MethodChannel _channel = MethodChannel('com.example.native_loader');

  static Future<void> showLoader() async {
    await _channel.invokeMethod('showLoader');
  }

  static Future<void> hideLoader() async {
    await _channel.invokeMethod('hideLoader');
  }
}
