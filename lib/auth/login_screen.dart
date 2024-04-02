import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/chat_screen.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Login'),
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
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 100.0,
              ),
              padding: const EdgeInsets.all(20),
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
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        kInputStyle.copyWith(labelText: 'Email Address'),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
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
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: const Text('Login')),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have a account?',
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        child: const Text(
                          ' Register!',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RegisterScreen.id);
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
