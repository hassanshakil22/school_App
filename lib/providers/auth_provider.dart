import 'package:flutter/widgets.dart';
import 'package:school_app/app/snackBar_ext.dart';
import 'package:school_app/models/auth_response.dart';
import 'package:school_app/repositories/auth_repository.dart';
import 'package:school_app/services/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.authRepository});

  final AuthRepository authRepository;
  static String token = '';

  Loading loading = Loading();
  bool? isLoggedIn = false;

  void setLoading(bool isLoading) {
    loading.setLoading(isLoading);
    notifyListeners();
  }

  void getSessionInfo() async {
    isLoggedIn = await UserPrefs.isSessionValid();
    print(isLoggedIn);
    notifyListeners();
  }

  void userLogin(BuildContext context, String email, String password) async {
    setLoading(true);

    final result = await authRepository.userLogin(
      email: email,
      password: password,
    );
    result.fold((left) => context.showSnackBar(left.message), (right) async {
      setLoading(false);
      isLoggedIn = true;

      await UserPrefs.setToken(right.token);
      await UserPrefs.setUserSessionExpiry(right.sessionExpiry);

      print(right);
      print(right.token);
      print(right.sessionExpiry);
    });
  }
}

class Loading {
  bool isLoading = false;
  void setLoading(bool isloading) {
    isLoading = isloading;
  }
}
