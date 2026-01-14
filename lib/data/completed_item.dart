class CompletedItem {
  final String task;
  final int pomodoroSet;

  CompletedItem({
    required this.task, 
    required this.pomodoroSet
    });

  Map<String, dynamic> toMap() {
    return {
      'task': task,
      'pomodoroSet': pomodoroSet,
    };
  }
  
}