import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pomodoro_app/data/pom_model.dart';

class TimerScreen extends StatefulWidget {
  final PomodoroConfig config;

  const TimerScreen({super.key, required this.config});
  
  @override
  State<TimerScreen> createState(){
    return _TimerScreenState();
  }
}


class _TimerScreenState extends State<TimerScreen> {

// Variables
  int _secondsRemaining = 0;
  bool _isWorkSesh = true;
  bool _isRunning = false;
  Timer?_timer; // can be null whilst developing

// Functions
@override
  void initState(){
    super.initState();
    _resetTimer();
  }
  void _resetTimer(){
    if(_timer != null){
      _timer!.cancel();
    }
    setState(() {
      _isRunning = false;
      _isWorkSesh = true;
      _secondsRemaining = widget.config.totalSeconds;
    });
  }

  void _startTimer(){
    if(_isRunning){
      _pauseTimer();
      return;
    }
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(_secondsRemaining > 0){
        setState(() {
          _secondsRemaining--;
        });
      } else {
          _nextSession();
      }
    });
  }

  void _pauseTimer(){
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _nextSession(){
    if(_isWorkSesh){
      setState(() {
        _isWorkSesh = false;
        _secondsRemaining = widget.config.breakSeconds;
      });
    }else{
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

String _formatTime(int totalSeconds){
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }

@override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }



// Widget Design
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pomodoro Timer Display
            // Based on set text for: Study / Rest
            Text(
              'Time remaining',
              style: TextStyle(
                fontSize: 32,
                color: Colors.purple[200],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _formatTime(_secondsRemaining),
              style: const TextStyle(
                fontSize: 72,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Start/Pause Button
            ElevatedButton(
              onPressed: _startTimer,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: _isRunning ? Colors.red : Colors.white,
                foregroundColor: _isRunning ? Colors.white : Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                _isRunning ? 'PAUSE' : 'START',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}