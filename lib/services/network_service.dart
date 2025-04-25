import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';

class NetworkUtils {
  static Future<bool> isDeviceOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<bool> isApiReachable(String baseUrl) async {
    try {
      // Try connecting to the base URL directly (without specific endpoint)
      final socket = await Socket.connect(
        Uri.parse(baseUrl).host,
        Uri.parse(baseUrl).port,
        timeout: const Duration(seconds: 3)
      );
      socket.destroy();
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> ensureNetworkReady(String baseUrl) async {
    if (!await isDeviceOnline()) {
      throw const SocketException("No internet connection");
    }

    if (!await isApiReachable(baseUrl)) {
      throw const SocketException("API server unreachable");
    }
  }
}