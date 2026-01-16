import 'package:flutter/material.dart';
import 'package:pomodoro_app/data/pom_model.dart';
import 'package:pomodoro_app/pages/timer.dart';
import 'package:pomodoro_app/pages/settings.dart';
import 'package:pomodoro_app/components/navbar.dart';

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
  
  void _selectConfig(PomodoroConfig config) {
    setState(() {
      _currentConfig = config;
      activeScreen = 'timer-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;
    
    switch (activeScreen) {
      case 'settings-screen':
        screenWidget = SettingsScreen(
          currentConfig: _currentConfig,
          onConfigChanged: _selectConfig,
        );
        break;
      case 'timer-screen':
      default:
        screenWidget = TimerScreen(
          config: _currentConfig,
          key: ValueKey(_currentConfig.hashCode), // This ensures widget rebuilds
        );
    }

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
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
                child: screenWidget,
              ),
            ),
            Navbar(onNavigate: switchScreen),
          ],
        ),
      ),
    ); 
  }
}