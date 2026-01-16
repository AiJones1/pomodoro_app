class PomodoroConfig{
  const PomodoroConfig({
    required this.workDuration, 
    required this.breakDuration,
    required this.totalSets
  });

  final int workDuration;
  final int breakDuration;
  final int totalSets;
  
  int get totalSeconds => workDuration * 60;
  int get breakSeconds => breakDuration * 60;
}

class PresetConfigs{
  static final List<PomodoroConfig> presets = [
    PomodoroConfig(workDuration: 25, breakDuration: 5, totalSets: 4),
    PomodoroConfig(workDuration: 45, breakDuration: 15, totalSets: 4),
    PomodoroConfig(workDuration: 50, breakDuration: 10, totalSets: 4),
  ];

  static PomodoroConfig get defaultConfig => presets[0];
  
  static PomodoroConfig customConfig(int workDuration, int breakDuration, int totalSets) {
    return PomodoroConfig(
      workDuration: workDuration,
      breakDuration: breakDuration,
      totalSets: totalSets
    );
  }
}