import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: 483.4859619140625,
              height: 288.1270751953125,
              decoration: BoxDecoration(color: Color(0xff7c1aca))),
          Text("Sign Up",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
              )),
          Container(
            width: 148,
            height: 0,
          ),
          Container(
            width: 310,
            height: 0,
          ),
          Container(
            width: 310,
            height: 0,
          ),
          Text("First Name",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              )),
          Container(
            width: 310,
            height: 0,
          ),
          Text("Email",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              )),
          Text("Password",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              )),
          Container(
              width: 235,
              height: 54,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Color(0xff7c1aca))),
          Text("Sign Up",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              )),
          Text("Already have account?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ))
        ],
      ),
    );
  }
}
