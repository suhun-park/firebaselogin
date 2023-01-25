import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/home/view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final String? verificationId;

  SignUpScreen({required this.verificationId, Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    String phoneText;
    String? verificationId = widget.verificationId;
    TextEditingController phoneVerifyCode = TextEditingController();
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    );
    return
      Scaffold(
      body:Column(children: [
      const SizedBox(
        height: 200,
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "6자리",
          border: baseBorder,
          contentPadding: EdgeInsets.all(20),
          fillColor: Colors.black,
        ),
        controller: phoneVerifyCode,
        onChanged: (String value) {
          phoneText = value;
        },
      ),
      TextButton(onPressed: ()async{
        final credential = PhoneAuthProvider.credential(
            verificationId: verificationId.toString(),
            smsCode: phoneVerifyCode.text.toString());
        try {
          await auth.signInWithCredential(credential);
          Navigator.push(context, MaterialPageRoute(builder: (Context) => HomeScreen() ));

        }catch(e){
         setState(() {
           loading = false;
         });
          print(e);
        }

      }, child: Text("인증"))

    ]));
  }
}
