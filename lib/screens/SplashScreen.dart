import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String imagePath;
  final Duration duration;

  const SplashScreen({
    Key? key,
    required this.imagePath,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.forward();

    Timer(widget.duration, () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: FadeTransition(
          opacity: _controller,
          child: Image.asset(
            widget.imagePath,
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
