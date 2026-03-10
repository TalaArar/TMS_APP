import 'models.dart';

abstract class AppDataSource {
  Future<UserModel> login(String email, String password);
  Future<List<TicketModel>> fetchTickets();
}

class RemoteDataSourceImpl implements AppDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    if (email.isNotEmpty && password.isNotEmpty) {
      return UserModel(
        id: '1',
        name: 'Admin User',
        email: email,
        department: 'IT',
      );
    }
    throw Exception('Invalid Credentials');
  }

  @override
  Future<List<TicketModel>> fetchTickets() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      TicketModel(
        id: 'TKT-101',
        title: 'Fix login bug',
        status: 'Pending',
        department: 'IT',
        priority: 'High',
      ),
      TicketModel(
        id: 'TKT-102',
        title: 'Update server configuration',
        status: 'Approval',
        department: 'DevOps',
        priority: 'Critical',
      ),
      TicketModel(
        id: 'TKT-103',
        title: 'Replace network switch',
        status: 'Rejected',
        department: 'IT',
        priority: 'Medium',
      ),
    ];
  }
}
