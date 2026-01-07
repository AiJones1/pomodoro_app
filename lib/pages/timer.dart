import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pomodoro_app/data/pom_model.dart';
import 'package:pomodoro_app/components/todo_list.dart';

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
  bool _transitioning = false;
  
  int totalSets = 4;      // Initially hard coded, may allow users to change later

  // Tracking stage of pomodoro
  int _currentSet = 1;

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
      _currentSet = 1;
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
      if(_currentSet < totalSets){
        // Check if more sets remain
        setState(() {
          _currentSet++;
          _isWorkSesh = true;
          _secondsRemaining = widget.config.totalSeconds;
        });
        // Else end pomodoro
      } else {
      _timer?.cancel();
        setState(() {
          _resetTimer();
          _isRunning = false;
        });
     } 
    }
  }
void _transitionTimer(){
  setState(() {
    _secondsRemaining = 10;

  });
}

double _updateProgress(){
  if(!_transitioning){
    double total = _isWorkSesh ? widget.config.totalSeconds.toDouble() : widget.config.breakSeconds.toDouble();
    return _secondsRemaining / total;
  }else{
    double left = (_secondsRemaining-10).toDouble().abs();
    return left / 10.0;
  }
    
  }

String _formatTime(int totalSeconds){
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }

String _sessionType(){
    return _isWorkSesh ? 'FOCUS' : 'RELAX';
  }


void testButton(){
  _transitionTimer();
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

            // Circular progress indicator
            Stack(
              alignment: Alignment.center,
              children:[
                CircularProgressIndicator(
                  value: _updateProgress(),
                  backgroundColor: const Color.fromARGB(255, 71, 71, 71),
                  color: _isWorkSesh ? 
                    const Color.fromARGB(255, 197, 196, 196) : const Color.fromARGB(255, 125, 192, 255),
                  strokeWidth: 10,
                  constraints: BoxConstraints.expand(
                    width: 300,
                    height: 290,
                    // Adjust size as needed for various phone (tested on pixel 9pro xl)
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      // Formatted timer string
                      Text(
                        _formatTime(_secondsRemaining),
                        style: const TextStyle(
                          fontSize: 72,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ) 
              ] 
            ),
            const SizedBox(height: 10),
            Text(
              _sessionType(),
              style: TextStyle(
                fontSize: 32,
                color: const Color.fromARGB(255, 252, 252, 252),
              ),
            ),
            Text(
              'Set $_currentSet of $totalSets',
              style: TextStyle(
                fontSize: 24,
                color: const Color.fromARGB(255, 252, 252, 252),
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(height: 40),
            // Start/Pause Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ), 
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ), 
                ElevatedButton(onPressed: testButton, child: const Text('TEST')),                                
              ]),
            // Task list display
            TodoList(),
          ],
        ),
      ),
      
    );
  }
}