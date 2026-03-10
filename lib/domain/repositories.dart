import 'entities.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> logout();
}

abstract class TicketRepository {
  Future<List<Ticket>> getTickets();
}
