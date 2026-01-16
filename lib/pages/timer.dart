import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pomodoro_app/data/pom_model.dart';
import 'package:pomodoro_app/components/todo_list.dart';

class TimerScreen extends StatefulWidget {
  final PomodoroConfig config;

  const TimerScreen({super.key, required this.config});
  
  @override
  TimerScreenState createState(){
    return TimerScreenState();
  }
}


class TimerScreenState extends State<TimerScreen> {
  void resetTimer() {
    _resetTimer();
  }
// Variables
  int _secondsRemaining = 10;
  Timer? _timer;
  bool _isRunning = false;
  bool _middleSetTransition = false;
  String _session = 'work'; // 'break' or 'transition'
  int get totalSets => widget.config.totalSets; // Use config value
  final int _transitionSeconds = 6;
  int _currentSet = 1;



// Functions
  // Extra fn to handle config changes  
  @override
  void didUpdateWidget(TimerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if config actually changed
    if (oldWidget.config.workDuration != widget.config.workDuration ||
        oldWidget.config.breakDuration != widget.config.breakDuration ||
        oldWidget.config.totalSets != widget.config.totalSets) {
      _resetTimer();
    }
  }

@override
  void initState(){
    super.initState();
    _resetTimer();
  }

  void _resetTimer(){
    if(_timer != null){
      _timer!.cancel();
      _timer = null;
    }
    setState(() {
      _isRunning = false;
      _session = 'start';
      _currentSet = 1;
      _middleSetTransition = false;
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
      if (_secondsRemaining == 0) {
        setState(() {
          if(_session =='break' && _currentSet == totalSets){
            timer.cancel();
          }else{
            _nextSession();
          }
        });
      } else {
        setState(() {
          if(_session == 'start'){
            _session = 'transition';
            _secondsRemaining = _transitionSeconds;
          }
          _secondsRemaining--;
        });
      }
    });
  }

  void _pauseTimer(){
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _nextSession() {
    // Prevent bugs from next session logic
    if(_session == 'start') {
      _session = 'transition';
      _secondsRemaining = _transitionSeconds;
      return;
    }
    if(_session == 'break' && _currentSet == totalSets){
      return;
    }
    if (_session == 'transition') {
      if(!_middleSetTransition){
        _middleSetTransition = true;
        _session = 'work';
        _secondsRemaining = widget.config.totalSeconds;
      } else {
        _middleSetTransition = false;
        _session = 'break';
        _secondsRemaining = widget.config.breakSeconds;
      }
    }else if(_session == 'work'){
      _session = 'transition';
      _secondsRemaining = _transitionSeconds;
    }else if(_session == 'break'){
      _currentSet++;
      _session = 'transition';
      _secondsRemaining = _transitionSeconds;
    }
  }

double _updateProgress(){
    if(_session == 'transition') {
      double total = 10.0;
      return (_secondsRemaining-total).toDouble().abs() / total;
    }else{
      double total = _secondsRemaining.toDouble();
      switch(_session){
        case 'work':
          total = widget.config.totalSeconds.toDouble();
          break;
        case 'break':
          total = widget.config.breakSeconds.toDouble();
          break;
        default:
          total = 1.0;
      }
      return _secondsRemaining / total;
    }
  }

String _formatTime(int totalSeconds){
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(1,'0')}:${seconds.toString().padLeft(2,'0')}';
  }

  Color _sessionColor() {
    switch (_session) {
      case 'work':
        return Colors.red;
      case 'break':
        return Colors.green;
      case 'transition':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _sessionLabel() {
    switch (_session) {
      case 'work':
        return 'Focus Time';
      case 'break':
        return 'Break';
      case 'transition':
        return 'Ready in ...';
      case 'start':
        return 'Pomodoro Session';
      default:
        return '';
    }
  }
  
  
   // testing timer with UI
  void testButton(){
    // Change as needed
    _nextSession();
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
      height: MediaQuery.of(context).size.height * 0.9,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pomodoro Timer Display
              Text(
              _sessionLabel(),
              style: TextStyle(
                fontSize: 35,
                color: const Color.fromARGB(255, 252, 252, 252),
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 5.0,
                    color: const Color.fromARGB(115, 0, 0, 0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Circular progress indicator
            Stack(
              alignment: Alignment.center,
              children:[
                CircularProgressIndicator(
                  value: _updateProgress(),
                  backgroundColor: const Color.fromARGB(255, 71, 71, 71),
                  color: _sessionColor(),
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