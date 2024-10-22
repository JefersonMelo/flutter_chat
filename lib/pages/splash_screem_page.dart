import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class SplashScreemPage extends StatefulWidget {
  const SplashScreemPage({super.key});

  @override
  State<SplashScreemPage> createState() => _SplashScreemPageState();
}

class _SplashScreemPageState extends State<SplashScreemPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent.shade700, Colors.redAccent.shade700],
          )),
          child: Center(
            child: AnimatedTextKit(
              onFinished: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const LoginPage()));
              },
              animatedTexts: [
                FadeAnimatedText(
                  'Flutter',
                  duration: const Duration(milliseconds: 1300),
                  textStyle: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                ScaleAnimatedText(
                  'Template',
                  duration: const Duration(milliseconds: 1300),
                  textStyle: const TextStyle(fontSize: 70.0, fontFamily: 'Canterbury'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
