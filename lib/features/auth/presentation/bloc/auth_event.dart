import '../../../../core/bloc/base_event.dart';

class LoginRequested extends BaseEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });
}
