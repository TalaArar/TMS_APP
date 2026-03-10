import '../domain/entities.dart';

class TicketModel extends Ticket {
  TicketModel({
    required String id,
    required String title,
    required String status,
    required String department,
    required String priority,
  }) : super(
         id: id,
         title: title,
         status: status,
         department: department,
         priority: priority,
       );

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      department: json['department'],
      priority: json['priority'],
    );
  }
}

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String department,
  }) : super(id: id, name: name, email: email, department: department);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      department: json['department'],
    );
  }
}
