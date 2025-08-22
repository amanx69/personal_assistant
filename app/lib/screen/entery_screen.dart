import 'package:app/screen/chat_screen.dart';
import 'package:app/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class EnteryScreen extends StatefulWidget {
  const EnteryScreen({super.key});

  @override
  _EnteryScreenState createState() => _EnteryScreenState();
}

class _EnteryScreenState extends State<EnteryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _girlAnimation;
  late Animation<double> _bubbleAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _girlAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _bubbleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.elasticOut),
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 3), (){

      //! go to  homescreen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      
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
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Girl Image slides in
            SlideTransition(
              position: _girlAnimation,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/girl.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Speech Bubble pops up
            ScaleTransition(
              scale: _bubbleAnimation,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Hi! aman',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}