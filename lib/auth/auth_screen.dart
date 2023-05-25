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
    return Scaffold(
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
                    Text(
                      'Flash_Chat_',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Text('Already have a account?'),
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
                  child: Text('Login')),
              SizedBox(height: 10.0),
              Text('Don\'t have a account?'),
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
                  child: Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}
