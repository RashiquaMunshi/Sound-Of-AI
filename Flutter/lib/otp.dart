import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:heartdisease_pred/phone.dart';
class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code="";
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.lightGreen,
        title: Text('OTP Verification'),
      ),
      body: Container(
        margin:EdgeInsets.only(left:25,right: 25),
        alignment:Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/heart1.jpg',width:120,height: 120),
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
              Text("Enter OTP",
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged:(value){
                  code = value;
                },
              ),
              SizedBox(
                height:20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(onPressed: () async {
                  try {
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: MyPhone.verify, smsCode: code);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    Navigator.pushNamedAndRemoveUntil(context, 'loggedin',(route) => false);
                  }
                  catch(e){
                    print("wrong otp");
                  }
                }, child: Text("Verify"),style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: TextStyle(
                      fontWeight:FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    )
                ),
                ),
              ),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, 'phone',arguments: (route) => false);
              },
                child:Text("Edit Phone Number?",style:TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
