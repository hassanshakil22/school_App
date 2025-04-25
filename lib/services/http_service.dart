import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:school_app/app/api_urls.dart';
import 'package:school_app/app/http_codes.dart';
import 'package:school_app/app/http_exceptions.dart';
import 'package:school_app/providers/auth_provider.dart';
import 'package:school_app/services/network_service.dart';

class HttpService {
  final String baseUrl;
  final Duration timeout;

  HttpService({
    this.baseUrl = baseURL,
    this.timeout = const Duration(seconds: 15),
  });

  void _log(String message) {
    print('[API LOG]: $message');
  }

  Future<dynamic> get(String path) async {
    try {
      // In your HttpService:
      await NetworkUtils.ensureNetworkReady(baseUrl);
      final uri = Uri.parse(baseUrl + path);

      _log("GET Request: $uri");

      final response = await http
          .get(
            uri,
            headers: {'accept': '*/*', 'Content-Type': 'application/json'},
          )
          .timeout(timeout);

      _log("Response Status: ${response.statusCode}");
      _log("Response Body: ${response.body}");
      if (response.statusCode != HttpCodes.Accepted &&
          response.statusCode != HttpCodes.Created &&
          response.statusCode != HttpCodes.OK) {
        _handleErrors(json.decode(response.body));
      }
      return json.decode(response.body);
    } on SocketException {
      throw const SocketException("No internet connection");
    } on TimeoutException {
      throw TimeoutException('API not responded in time');
    }
  }

  Future<dynamic> post(
    String path, {
    required Map<dynamic, dynamic> requestBody,
  }) async {
    try {
      // await NetworkUtils.ensureNetworkReady(baseUrl);

      final uri = Uri.parse(baseUrl + path);

      _log("POST Request: $uri");
      _log("Request Body: ${jsonEncode(requestBody)}");

      final response = await http
          .post(
            uri,
            body: jsonEncode(requestBody),
            headers: {'accept': '*/*', 'Content-Type': 'application/json'},
          )
          .timeout(timeout);

      _log("Response Status: ${response.statusCode}");
      _log("Response Body: ${response.body}");
      if (response.statusCode != HttpCodes.Accepted &&
          response.statusCode != HttpCodes.Created &&
          response.statusCode != HttpCodes.OK) {
        _handleErrors(json.decode(response.body));
      }
      return json.decode(response.body);
    } on SocketException {
      throw const SocketException("No internet connection");
    } on TimeoutException {
      throw TimeoutException('API not responded in time');
    }
  }

  // Future<dynamic> patch(
  //   String path, {
  //   required Map requestBody,
  // }) async {
  //   try {
  //     final uri = Uri.parse(baseUrl + path);

  //     _log("POST Request: $uri");
  //     _log("Headers: Authorization: ${AuthProvider.token}");

  //     final response = await http.patch(
  //       uri,
  //       body: jsonEncode(requestBody),
  //      headers:  {
  //     'accept': '*/*',
  //     'Content-Type': 'application/json',
  //   }
  //     ).timeout(timeout);

  //     _log("Response Status: ${response.statusCode}");
  //     _log("Response Body: ${response.body}");

  //     _handleErrors(json.decode(response.body));

  //     return json.decode(response.body);
  //   } on SocketException {
  //     throw const SocketException("No internet connection");
  //   } on TimeoutException {
  //     throw TimeoutException('API not responded in time');
  //   }
  // }
  void _handleErrors(Map<String, dynamic> response) {
    if (response.containsKey("errors")) {
      final Map<String, dynamic> errorMap = response["errors"];
      final List<String> errorMessages = [];

      errorMap.forEach((key, value) {
        if (value is List) {
          errorMessages.addAll(value.map((e) => "$key: $e"));
        } else {
          errorMessages.add("$value");
        }
      });

      throw BadRequestException(errorMessages.join("\n"));
    }

    final statusCode = response["status"] ?? 0;
    final title = response["title"] ?? "An unexpected error occurred.";

    switch (statusCode) {
      case HttpCodes.BadRequest:
        throw BadRequestException(title);
      case HttpCodes.Unauthorized:
      case HttpCodes.Forbidden:
        throw UnauthorizedException(title);
      case HttpCodes.NotFound:
        throw NotFoundException(title);
      case HttpCodes.InternalServerError:
        throw InternalServerErrorException(title);
      case HttpCodes.ServiceUnavailable:
      case HttpCodes.GatewayTimeout:
        throw ServiceUnavailableException(title);
      default:
        throw UnknownException(title);
    }
  }
}
