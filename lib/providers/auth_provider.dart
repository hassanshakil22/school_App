import 'package:flutter/widgets.dart';
import 'package:school_app/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier{
  AuthProvider({required this.authRepository});

  final AuthRepository authRepository;
  static String token = '';

  
  Loading loading = Loading();
  bool? isLoggedIn = false ;

  void setLoading(bool isLoading) {
    loading.setLoading(isLoading);
    notifyListeners();
  }





}


class Loading {
  bool isLoading = false;
  void setLoading(bool isloading) {
    isLoading = isloading;
  }
}