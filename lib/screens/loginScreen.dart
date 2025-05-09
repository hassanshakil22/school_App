import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/app/route_extensions.dart';
import 'package:school_app/app/size_extensions.dart';
import 'package:school_app/providers/auth_provider.dart';
import 'package:school_app/screens/homeScreen.dart';
import 'package:school_app/app/theme/app_colours.dart';
import 'package:school_app/widgets/customButton.dart';
import 'package:school_app/widgets/text_field.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();

FocusNode emailFocus = FocusNode();
FocusNode passFocus = FocusNode();

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: AppColors.ScaffoldbackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: context.h * 0.2),

              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor2,
                        AppColors.primaryColor1,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  height: context.h * 0.19,
                  width: context.w * 0.6,

                  child: SizedBox(),
                ),
              ),
              SizedBox(height: context.h * 0.08),
              Text(
                "Login To your account",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: context.h * 0.02),

              CustomTextField(
                textController: emailController,
                hint: "Enter your email",
                focus: emailFocus,
              ),
              SizedBox(height: context.h * 0.05),

              PasswordTextField(
                controller: passController,
                focus: passFocus,
                isObscureText: false,
                hint: "Enter your password",
              ),
              SizedBox(height: context.h * 0.1),
              Custombutton2(
                isloading: authProvider.loading.isLoading,
                width: context.w * 0.5,
                height: context.h * 0.05,
                text: "Login",
                ontap: () {
                  authProvider.userLogin(
                    context,
                    emailController.text.trim(),
                    passController.text.trim(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
