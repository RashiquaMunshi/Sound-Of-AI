import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heartdisease_pred/loggedin.dart';
import 'package:heartdisease_pred/phone.dart';
import 'package:heartdisease_pred/otp.dart';
import 'next.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {
      'phone':(context)=>MyPhone(),
      'otp':(context)=>MyOtp(),
      'loggedin':(context)=>LoggedIn(),
      'next':(context)=>Next(),
    },
  ));
}