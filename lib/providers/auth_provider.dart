import 'package:flutter/widgets.dart';
import 'package:school_app/app/appConstants.dart';
import 'package:school_app/app/snackBar_ext.dart';
import 'package:school_app/models/auth_response.dart';
import 'package:school_app/repositories/auth_repository.dart';
import 'package:school_app/services/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.authRepository});

  final AuthRepository authRepository;
   

  Loading loading = Loading();
  bool? isLoggedIn = false;

  void setLoading(bool isLoading) {
    loading.setLoading(isLoading);
    notifyListeners();
  }

  void getSessionInfo() async {
    isLoggedIn = await UserPrefs.isSessionValid();
    print(isLoggedIn);
    Appconsts.token = await UserPrefs.getToken();
    print( "token : ${Appconsts.token}");
    notifyListeners();
  }

  void userLogin(BuildContext context, String email, String password) async {
    setLoading(true);

    final result = await authRepository.userLogin(
      email: email,
      password: password,
    );
    setLoading(false);

    result.fold((left) => context.showSnackBar(left.message), (right) async {
      print(right);
      print("token ${right.token}");
      print("session expiry  ${right.sessionExpiry}");

      await UserPrefs.setToken(right.token);
      await UserPrefs.setUserSessionExpiry(right.sessionExpiry);
      isLoggedIn = true;
      notifyListeners();

    });
  }
  void logout() async {
  await UserPrefs.delToken();
  isLoggedIn = false;
  print(isLoggedIn);
  Appconsts.token = '';
  notifyListeners();
}
}

class Loading {
  bool isLoading = false;
  void setLoading(bool isloading) {
    isLoading = isloading;
  }
}
