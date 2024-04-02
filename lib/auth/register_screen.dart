import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlueAccent, Colors.white],
                stops: [0.1, 0.7])),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 100.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40.0),
                  Image.asset(
                    'images/logo.png',
                    height: 80.0,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Flash_Chat_',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        kInputStyle.copyWith(labelText: 'Email Address'),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: kInputStyle.copyWith(labelText: 'Password'),
                  ),
                  const SizedBox(height: 30.0),
                  Flexible(
                    child: Container(),
                  ),
                  MaterialButton(
                      minWidth: 250.0,
                      height: 42.0,
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushNamed(context, LoginScreen.id);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          // print(e);
                        }
                        // Navigator.pushNamed(context, ChatScreen.id);
                      },
                      child: const Text('Register')),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have a account?',
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        child: const Text(
                          ' Login!',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
