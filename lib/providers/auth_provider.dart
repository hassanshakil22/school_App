import 'package:flutter/widgets.dart';
import 'package:school_app/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier{
  AuthProvider({required this.authRepository});

  final AuthRepository authRepository;
  static String token = '';
  


}