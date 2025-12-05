class PomodoroConfig{
  const PomodoroConfig({required this.workDuration, required this.breakDuration});

  final int workDuration;
  final int breakDuration;
  
  int get totalSeconds => workDuration * 60;
  int get breakSeconds => breakDuration * 60;
}

class PresetConfigs{
  static final List<PomodoroConfig> presets = [
    PomodoroConfig(workDuration: 25, breakDuration: 5),
    PomodoroConfig(workDuration: 45, breakDuration: 15),
    PomodoroConfig(workDuration: 50, breakDuration: 10),
  ];

  static PomodoroConfig get defaultConfig => presets[0];
}