import 'package:flutter/material.dart';
import 'package:pomodoro_app/data/pom_model.dart';

class SettingsScreen extends StatefulWidget {
  final PomodoroConfig currentConfig;
  final Function(PomodoroConfig) onConfigChanged;
  
  const SettingsScreen({
    super.key,
    required this.currentConfig,
    required this.onConfigChanged,
  });
  
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late int _workDuration;
  late int _breakDuration;
  late int _totalSets;
  
  @override
  void initState() {
    super.initState();
    _workDuration = widget.currentConfig.workDuration;
    _breakDuration = widget.currentConfig.breakDuration;
    _totalSets = widget.currentConfig.totalSets;
  }
  
  void _saveSettings() {
  final newConfig = PomodoroConfig(
    workDuration: _workDuration,
    breakDuration: _breakDuration,
    totalSets: _totalSets,
  );
  widget.onConfigChanged(newConfig);
  }
  
  void _applyPreset(PomodoroConfig preset) {
    setState(() {
      _workDuration = preset.workDuration;
      _breakDuration = preset.breakDuration;
      _totalSets = preset.totalSets;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Settings'),
        backgroundColor: const Color(0xFF4B0082),
        foregroundColor: Colors.white,
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Preset Buttons
              const Text(
                'Quick Presets',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: PresetConfigs.presets.map((preset) {
                  return ChoiceChip(
                    label: Text('${preset.workDuration}/${preset.breakDuration}'),
                    selected: _workDuration == preset.workDuration && 
                             _breakDuration == preset.breakDuration,
                    onSelected: (selected) {
                      if (selected) {
                        _applyPreset(preset);
                      }
                    },
                    selectedColor: Colors.white,
                    backgroundColor: Colors.purple[300],
                    labelStyle: TextStyle(
                      color: _workDuration == preset.workDuration && 
                             _breakDuration == preset.breakDuration
                          ? Colors.purple
                          : Colors.white,
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 30),
              
              // Work Duration Slider
              Text(
                'Work Duration: $_workDuration minutes',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Slider(
                value: _workDuration.toDouble(),
                min: 5,
                max: 90,
                divisions: 17,
                label: '$_workDuration min',
                onChanged: (value) {
                  setState(() {
                    _workDuration = value.round();
                  });
                },
                activeColor: Colors.white,
                inactiveColor: Colors.purple[300],
              ),
              
              const SizedBox(height: 20),
              
              // Break Duration Slider
              Text(
                'Break Duration: $_breakDuration minutes',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Slider(
                value: _breakDuration.toDouble(),
                min: 1,
                max: 30,
                divisions: 29,
                label: '$_breakDuration min',
                onChanged: (value) {
                  setState(() {
                    _breakDuration = value.round();
                  });
                },
                activeColor: Colors.white,
                inactiveColor: Colors.purple[300],
              ),
              
              const SizedBox(height: 20),
              
              // Total Sets Slider
              Text(
                'Total Sets: $_totalSets',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Slider(
                value: _totalSets.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: '$_totalSets sets',
                onChanged: (value) {
                  setState(() {
                    _totalSets = value.round();
                  });
                },
                activeColor: Colors.white,
                inactiveColor: Colors.purple[300],
              ),
              
              const SizedBox(height: 40),
              
              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: _saveSettings,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Save Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 10),
              // Text('Current Config: ',
              //   style: TextStyle(
              //     fontSize: 24,
              //     color: Colors.white,
              //   ),
              // ),
              // Text('Work: $_workDuration min, Break $_breakDuration min, Sets: $_totalSets',
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: Colors.white,
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}