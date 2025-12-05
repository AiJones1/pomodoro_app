import 'package:flutter/material.dart';
import 'package:pomodoro_app/data/pom_model.dart';
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
  late PomodoroConfig _currentConfig = PresetConfigs.defaultConfig;

// Functions
  void switchScreen(String screenIdentifier){
    setState(() {
      activeScreen = screenIdentifier;
    });
  }
  // void _selectConfig(PomodoroConfig config) {
  //   setState(() {
  //     _currentConfig = config;
  //   });
  // }

// Elements and styles  
  @override
  Widget build( context) {
    Widget screenWidget = TimerScreen(config: _currentConfig); // Update later to be welcome screen or setup


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
          child: Center(
            child: screenWidget,
            // Change to screenWidget when more screens are added
          ),
        ),
      ),
    ); 
  }
}


