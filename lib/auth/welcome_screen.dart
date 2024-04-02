import 'package:flash_chat/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF4A148C), Colors.white])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('images/logo.png'),
              const Expanded(
                  child: Text(
                'Flash_Chat_',
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w500),
              )),
              const Text(
                'Read our privacy policy. Tap "Agree & Continue" to accept all the Terms of Service.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
              const SizedBox(height: 10.0),
              FilledButton(
                  style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 80.0)),
                  onPressed: () {
                    Navigator.pushNamed(context, AuthScreen.id);
                  },
                  child: const Text('Agree & Continue'))
            ],
          ),
        ),
      ),
    );
  }
}
