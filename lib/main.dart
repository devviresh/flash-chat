import 'package:flash_chat/auth/auth_screen.dart';
import 'package:flash_chat/auth/login_screen.dart';
import 'package:flash_chat/auth/register_screen.dart';
import 'package:flash_chat/auth/welcome_screen.dart';
import 'package:flash_chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        AuthScreen.id: (context) => const AuthScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
