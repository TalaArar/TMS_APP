import '../core/usecase.dart';
import 'repositories.dart';
import 'entities.dart';

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<User> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class GetTicketsUseCase implements UseCase<List<Ticket>, NoParams> {
  final TicketRepository repository;
  GetTicketsUseCase(this.repository);

  @override
  Future<List<Ticket>> call(NoParams params) async {
    return await repository.getTickets();
  }
}
