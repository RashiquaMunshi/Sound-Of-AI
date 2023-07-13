import 'package:flutter/material.dart';
class Choice extends StatefulWidget {
  const Choice({super.key});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  // String get email =>"";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black38,
        title: Text('Login Choice'),
      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back2.jpg'), // Path to your image asset
            fit: BoxFit.cover, // Adjust how the image fits the container
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [Colors.blue.shade700, Colors.white], // Define the gradient colors
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
               // Image.asset('assets/audioui.jpeg',width:150,height: 150),
                SizedBox(
                  height: 25,
                ),
                const Text(
                  "Welcome",
                  style:TextStyle(
                    fontSize: 30,
                    color:Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height:10
                ),
                const Text(
                  "Choose Login Option",
                  style:TextStyle(
                    fontSize: 25,
                    color:Colors.white,
                  ),
                ),
                const SizedBox(
                    height:80
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(style: TextButton.styleFrom(backgroundColor: Colors.blue.shade600),
                        onPressed:(){
                          Navigator.pushNamed(context, "login_screen");
                        },
                        child: const Text("Email and Password", style: TextStyle(color: Colors.white,fontSize: 25),)),
                    SizedBox(
                      height:15,
                    ),
                    const Text(
                      "OR",
                      style:TextStyle(
                        fontSize: 20,
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height:15,
                    ),
                    TextButton(style: TextButton.styleFrom(backgroundColor: Colors.blue.shade600),
                        onPressed:(){
                          Navigator.pushNamed(context, "phone");
                        },
                        child: const Text("Phone and OTP", style: TextStyle(color: Colors.white, fontSize: 25),)),
                    SizedBox(
                      height:20,
                    ),
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