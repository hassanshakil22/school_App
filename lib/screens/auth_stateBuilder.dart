import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/providers/auth_provider.dart';
import 'package:school_app/screens/homeScreen.dart';
import 'package:school_app/screens/loginScreen.dart';

class AuthStateBuilder extends StatefulWidget {
  const AuthStateBuilder({super.key});

  @override
  State<AuthStateBuilder> createState() => _AuthStateBuilderState();
}

class _AuthStateBuilderState extends State<AuthStateBuilder> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init()  {
    context.read<AuthProvider>().getSessionInfo();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<AuthProvider>().isLoggedIn == true
        ? Homescreen()
        : const Loginscreen();
  }
}
