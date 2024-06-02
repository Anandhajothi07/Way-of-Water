//import 'package:app/pages/HomePage.dart';
// ignore_for_file: prefer_const_constructors

import 'package:app/pages/HomePage.dart';
//import 'package:app/pages/StartPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BootUpPage(),
    );
  }
}

class BootUpPage extends StatefulWidget {
  @override
  _BootUpPageState createState() => _BootUpPageState();
}

class _BootUpPageState extends State<BootUpPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward().then((_) {
      // After animation completes, navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value,
                  child: Text(
                    'Way of Water',
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto', // Use the desired font
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 200 + 200 * _animation.value,
                height: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Color.fromARGB(255, 40, 120, 204).withOpacity(0.2)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: Text(
                  'Adding Dimensions to the Way of Watering',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    fontFamily: 'Roboto', // Use the desired font
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
