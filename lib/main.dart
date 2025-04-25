import 'package:flutter/material.dart';
import 'package:school_app/providers/auth_provider.dart';
import 'package:school_app/providers/home_provider.dart';
import 'package:school_app/screens/auth_stateBuilder.dart';
import 'package:school_app/screens/loginScreen.dart';
import 'package:school_app/services/dependency_injection.dart';
import 'package:provider/provider.dart';
import 'package:school_app/services/shared_preferences.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await UserPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => sl<HomeProvider>()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: const AuthStateBuilder(),
          );
        },
      ),
    );
  }
}
