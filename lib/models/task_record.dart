class TaskRecord {
  const TaskRecord({required this.id, required this.task, required this.dueDate});

  final int id;
  final String task;
  final DateTime dueDate;

  factory TaskRecord.fromMap(Map<String, Object?> map) => TaskRecord(
        id: map['id'] as int,
        task: map['task'] as String,
        dueDate: DateTime.parse(map['due_date'] as String),
      );
}
