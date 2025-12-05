import 'package:flutter/material.dart';
import 'dart:async';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});
  
  @override
  State<TimerScreen> createState(){
    return _TimerScreenState();
  }
}

class _TimerScreenState extends State<TimerScreen> {
  // Variables and functions for TimerScreen can be added here
// Variables and functions
  int workMinutes = 25;
  int breakMinutes = 5;
  int sets = 4;
  int _totalSeconds = 25 * 60;

  int minutes =25;
  int seconds =0;
  String minutesStr ='';
  String secondsStr ='';

  late Timer _timer;
  void uptdateClock(){
    setState(() {
      minutes = _totalSeconds ~/60;
      seconds = _totalSeconds %60;
      minutesStr = minutes.toString().padLeft(2,'0');
      secondsStr = seconds.toString().padLeft(2,'0');
    });
  }
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(_totalSeconds==0){
        setState(() {
          timer.cancel();
        });
      }else{
        setState(() {
          uptdateClock();
          _totalSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
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
              '$minutesStr:$secondsStr',
              style: const TextStyle(
                fontSize: 72,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Start/Pause Button
            ElevatedButton(
              onPressed: () {
                startTimer();
              },
              style: ElevatedButton.styleFrom(
                
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.white,
                foregroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
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