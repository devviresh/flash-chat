import 'package:flash_chat/auth/login_screen.dart';
import 'package:flash_chat/auth/register_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String id = 'auth_screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.lightBlue, Colors.white],
              stops: [0.1, 0.7])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset(
                        'images/logo.png',
                        height: 60.0,
                      ),
                      const Text(
                        'Flash_Chat_',
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Text('Already have a account?'),
                MaterialButton(
                    minWidth: 250.0,
                    height: 42.0,
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: const Text('Login')),
                const SizedBox(height: 10.0),
                const Text('Don\'t have a account?'),
                MaterialButton(
                    minWidth: 250.0,
                    height: 42.0,
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.id);
                    },
                    child: const Text('Register')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
