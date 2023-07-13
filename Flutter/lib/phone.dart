import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_2/otp.dart';
class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verify="";
  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countrycode=TextEditingController();
  var phone="";
  @override
  void initState(){
    countrycode.text="+91";
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black38,
        title: Text('Phone OTP'),
      ),
      body: Container(
        margin:EdgeInsets.only(left:25,right: 25),
        alignment:Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/photp.png',width:150,height: 150),
              SizedBox(
                height: 25,
              ),
              Text("Phone Verification", style: TextStyle(
                fontSize: 28,
                fontWeight:FontWeight.bold,
              ),),
              SizedBox(
                height: 10,
              ),
              Text("Enter Phone Number to register",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  border:Border.all(width:1,color:Colors.grey),
                ),
                child:Row(
                  children: [
                    SizedBox(
                      width:10,
                    ),
                    SizedBox(
                      width:40,
                      child:TextField(
                        controller: countrycode,
                      ),
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text("|",style: TextStyle(fontSize: 30,color: Colors.grey),),
                    SizedBox(
                      width:10,
                    ),
                    Expanded(
                      child:TextField(
                        onChanged:(value){
                          keyboardType:TextInputType.phone;
                          phone=value;
                        },
                        decoration: InputDecoration(
                            hintText: "PhoneNo."
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${countrycode.text+phone}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      MyPhone.verify=verificationId;
                      Navigator.pushNamed(context, "otp");
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                }, child: Text("Send OTP"),style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    textStyle: TextStyle(
                      fontWeight:FontWeight.bold,
                      fontSize:25,
                      color: Colors.black,
                    )
                ),
                ),
              ),
              SizedBox(
                height:80,
              ),
              TextButton(style: TextButton.styleFrom(backgroundColor: Colors.black38),
                  onPressed:(){
                    Navigator.pushNamed(context, "choice");
                  },
                  child: const Text("Login Choice", style: TextStyle(color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}

