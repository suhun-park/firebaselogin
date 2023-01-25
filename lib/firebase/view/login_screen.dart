import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/firebase/view/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final auth = FirebaseAuth.instance;

    TextEditingController phoneController = TextEditingController();
    String? phoneText = "";
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    );
    return
      Scaffold(
      body:Column(
      children: [
        SizedBox(height: 200,),

        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "+821231234123",
            border: baseBorder,
            contentPadding: EdgeInsets.all(20),
            fillColor: Colors.black,
          ),
          controller: phoneController,
          onChanged: (String value) {
            phoneText = value;
          },
        ),
        TextButton(
          onPressed: () {
             auth.verifyPhoneNumber(
                timeout: const Duration(seconds: 60),
                phoneNumber: phoneText,
                verificationCompleted: (_) {
                  setState(() {
                    loading = false;
                  });
                },
                verificationFailed: (e){
                  setState(() {
                    loading =false;
                  });
                },
                codeSent: (String verificationId, int? token){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpScreen(verificationId: verificationId,)));

                }, codeAutoRetrievalTimeout: (String verificationId) {

            },);
          },
          child: const Text("휴대폰인증"),

        ),
      ],
      ),
    );
  }
}