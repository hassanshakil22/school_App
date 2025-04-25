import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:school_app/app/api_urls.dart';
import 'package:school_app/models/auth_response.dart';
import 'package:school_app/services/http_service.dart';

class AuthRepository {

  AuthRepository({required this.httpService});

  final HttpService httpService;
   FutureEither1<AuthResponse>  userLogin(
      {required String email, required String password}) async {
    try {
      dynamic response = await httpService.post(ApiUrls.studentLogin,
          requestBody: {"email": email, "password": password});
      return Right(AuthResponse.fromJson(response as Map<String, dynamic>));
    } catch (e, stackTrace) {
      debugPrint("Error : $e\n StackTrace : $stackTrace");
      return Left(Failure(message: e.toString()));
    }

  }

  

}








typedef FutureEither0 = Future<Either<Failure, Success>>;
typedef FutureEither1<T> = Future<Either<Failure, T>>;
typedef Either0 = Either<Failure, Success>;
typedef Either1<T> = Either<Failure, T>;

Left<Failure, T> failure<T>(String message) {
  return Left(Failure(message: message));
}

Right<Failure, Success> success(String message) {
  return Right(Success(message: message));
}


class AppException {
  final String? code;
  final String message;

  AppException({required this.message, this.code});
}

class Success {
  final bool value;
  final String message;

  Success({
    required this.message,
    this.value = true,
  });
}

class Failure implements Exception {
  final String message;

  Failure({required this.message});
}
