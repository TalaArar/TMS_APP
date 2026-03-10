import '../domain/entities.dart';
import '../domain/repositories.dart';
import 'datasources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<void> logout() async {
    // Logic to clear tokens/cache
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

class TicketRepositoryImpl implements TicketRepository {
  final AppDataSource remoteDataSource;

  TicketRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Ticket>> getTickets() async {
    return await remoteDataSource.fetchTickets();
  }
}
