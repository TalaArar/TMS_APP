class Ticket {
  final String id;
  final String title;
  final String status;
  final String department;
  final String priority;

  Ticket({
    required this.id,
    required this.title,
    required this.status,
    required this.department,
    required this.priority,
  });
}

class User {
  final String id;
  final String name;
  final String email;
  final String department;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
  });
}

class Task {
  final String id;
  final String title;
  final String dueDate;
  final String priority;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });
}

class AppNotification {
  final String id;
  final String message;
  final String time;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}
