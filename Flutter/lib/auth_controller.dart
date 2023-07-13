import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_2/login_screen.dart';
import 'package:project_2/appchoice.dart';
class AuthController extends GetxController{
  static AuthController instance=Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user= Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user,_initialScreen);
  }
  _initialScreen(User? user){
    if(user==null){
      print("login page");
      Get.offAll(()=>const LoginScreen());
    }else{
      //var email;
      Get.offAll(()=>AppChoice());
    }
  }
  Future<void> register(String email,password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Account creation failed",
          style:TextStyle(
            color:Colors.white
          )
        ),
        messageText: Text(
          e.toString()
        )
      );
    }
  }
  Future<void> login(String email,password) async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
              "Login failed",
              style:TextStyle(
                  color:Colors.white
              )
          ),
          messageText: Text(
              e.toString()
          )
      );
    }
  }
  Future<void> logOut(String email,password) async {
      await auth.signOut();
    }
  }
