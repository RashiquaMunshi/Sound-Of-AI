import 'package:flutter/material.dart';
import 'package:project_2/auth_controller.dart';
import 'package:project_2/register.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black38,
        title: Text('Email Password'),
      ),
      body:Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/uiback.jpg'), // Path to your image asset
        //     fit: BoxFit.cover, // Adjust how the image fits the container
        //   ),
        // ),
      child:Center(
      child:SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/mail.png',width:150,height: 150),
          const SizedBox(
              height:25
          ),
          const SizedBox(
            height:25
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Enter Email",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(
              height:10
          ),
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Enter Password",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: Icon(Icons.remove_red_eye),
            ),
          ),
          const SizedBox(
              height:5,
          ),
          const SizedBox(
            height:5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
    //           TextButton(onPressed: (){}, child: const Text(
    //             "Forget Password?",style: TextStyle(color: Colors.black,fontSize: 15),
    // ))
            ],
          ),
          const SizedBox(
            height:25,
          ),
          GestureDetector(
            onTap: (){
              AuthController.instance.login(emailController.text.trim(),passwordController.text.trim());
            },
          child: Container(
            height: 60,
            width:double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors:[Colors.lightBlueAccent,Colors.blue]),
            ),
    child: MaterialButton(
       onPressed: (){
         AuthController.instance.login(emailController.text.trim(),passwordController.text.trim());
       },
       child:const Text(
         "LOGIN",
         style:TextStyle(
           fontSize: 25,
           color:Colors.white,
         )
       )
    ),
          ),
          ),
          const SizedBox(
            height:30,
          ),
          const Divider(
            height:30,
            color:Colors.black,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                // Navigator.pushNamed(context, 'register');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
              }, child: const Text(
                  "Click to Register Account", style: TextStyle(color: Colors.black,fontSize: 20),
              )),
              const SizedBox(
                height:30,
              ),
              TextButton(style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed:(){
                    Navigator.pushNamed(context, "choice");
                  },
                  child: const Text("Login Choice", style: TextStyle(color: Colors.white),)),
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