import 'package:get_it/get_it.dart';
import 'package:school_app/providers/auth_provider.dart';
import 'package:school_app/providers/home_provider.dart';
import 'package:school_app/repositories/auth_repository.dart';
import 'package:school_app/repositories/home_repository.dart';
import 'package:school_app/services/http_service.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  // Services
  sl.registerLazySingleton<HttpService>(() => HttpService());


  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepository(httpService: sl<HttpService>()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepository(httpService: sl<HttpService>()));

  // Providers
  sl.registerFactory<AuthProvider>(
      () => AuthProvider(authRepository: sl<AuthRepository>()));
  sl.registerFactory<HomeProvider>(
      () => HomeProvider(homeRepository: sl<HomeRepository>()));
}
