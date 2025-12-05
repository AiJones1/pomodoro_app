import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/timer.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});
  
  @override
  State<Pomodoro> createState(){
    return _PomodoroState();
  }
}

class _PomodoroState extends State<Pomodoro> {

// Variables
  var activeScreen = 'timer-screen';

// Functions
  void switchScreen(String screenIdentifier){
    setState(() {
      activeScreen = screenIdentifier;
    });
  }

// Elements and styles  
  @override
  Widget build( context) {
    Widget screenWidget = TimerScreen(); // Update later to be welcome screen or setup


    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF8A2BE2), 
                Color(0xFF4B0082), 
              ],
            ),
          ),
          child: const Center(
            child: TimerScreen(),
            // Change to screenWidget when more screens are added
          ),
        ),
      ),
    );   
  }
}


