import 'package:flutter/material.dart';
// import 'package:project_2/AppChoicelogin.dart';
// import 'package:project_2/login_screen.dart';
// import 'package:project_2/phone.dart';
class AppChoice extends StatefulWidget {
  const AppChoice({super.key});

  @override
  State<AppChoice> createState() => _AppChoiceState();
}

class _AppChoiceState extends State<AppChoice> {
  // String get email =>"";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black38,
        title: Text('App Choice'),
      ),
      body:Container(
        decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/back2.jpg'), // Path to your image asset
    fit: BoxFit.cover, // Adjust how the image fits the container
          // image: DecorationImage(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [Colors.blue.shade800, Colors.white], // Define the gradient colors
          ),
        ),

        child:Center(
          child:SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Sound Of AI",
                  style:TextStyle(
                    fontSize:40,
                    color:Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Image.asset('assets/audioui.jpeg',width:150,height: 150),
                SizedBox(
                  height: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(

                        style: TextButton.styleFrom(

                        backgroundColor: Colors.blue[700]),
                        onPressed:(){
                          Navigator.pushNamed(context, "loggedinheart");
                        },
                        child: const Text("Heart Disease Predictor", style: TextStyle(color: Colors.white,fontSize: 25),)),
                    SizedBox(
                      height:20,
                    ),
                    TextButton(style: TextButton.styleFrom(backgroundColor: Colors.blue[700]),
                        onPressed:(){
                          Navigator.pushNamed(context, "loggedin");
                        },
                        child: const Text("Urban Sound Classifier", style: TextStyle(color: Colors.white, fontSize:25),)),
                    SizedBox(
                      height:70,
                    ),
                    TextButton(style: TextButton.styleFrom(backgroundColor: Colors.white54),
                        onPressed:(){
                          Navigator.pushNamed(context, "choice");
                        },
                        child: const Text("Login Choice", style: TextStyle(color: Colors.black),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}