import 'package:flutter/material.dart';
import 'package:project_2/auth_controller.dart';
import 'package:project_2/login_screen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  Widget build(BuildContext context) {
    double w= MediaQuery.of(context).size.width;
    double h= MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black38,
        title: Text('Register'),
      ),
      body:InkWell(
      //padding: const EdgeInsets.all(30),
      child: Center(
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
            decoration:  const InputDecoration(
              labelText: "Enter Email",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(
              height:10
          ),
          // const SizedBox(
          //     height:25
          // ),
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
            height:10,
          ),
          GestureDetector(
            onTap:(){
              AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
            },
          child: Container(
            height: 60,
            width:double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors:[Colors.lightBlueAccent,Colors.blue]),
            ),
            child: MaterialButton(
                onPressed: (){
                  AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
                },
                child:const Text(
                    "Sign Up",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                // Navigator.pushNamed(context, 'login');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
              }, child: const Text(
                  "Sign In Page", style: TextStyle(color: Colors.black,fontSize: 20),
              )),
            ],
          ),
          // ),
        ],
      ),
    ),
    ),
      ),
    );
  }
}