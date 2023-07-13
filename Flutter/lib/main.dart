import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_2/auth_controller.dart';
import 'package:project_2/phone.dart';
import 'package:project_2/otp.dart';
import 'package:project_2/choicelogin.dart';
import './login_screen.dart';
import './register.dart';
import 'package:get/get.dart';
import 'package:project_2/next.dart';
import 'package:project_2/loggedin.dart';
import 'package:project_2/appchoice.dart';
import 'package:project_2/loggedinheart.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value)=>Get.put(AuthController()));
  runApp(const LoginUI());
}

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}
class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      initialRoute: 'choice',
        routes: {
          'login_screen':(context)=>const LoginScreen(),
          'register':(context)=>const RegisterScreen(),
          'phone':(context)=>MyPhone(),
          'otp':(context)=>MyOtp(),
          'choice':(context)=>Choice(),
          'appchoice':(context)=>AppChoice(),
          'loggedin':(context)=>LoggedIn(),
          'loggedinheart':(context)=>LoggedInHeart(),
          'next':(context)=>Next(),
    },
    );
  }
}
