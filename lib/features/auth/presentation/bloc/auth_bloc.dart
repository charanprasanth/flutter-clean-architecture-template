import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/errors/app_exception.dart';
import '../../data/auth_repository.dart';
import 'auth_event.dart';

class AuthBloc extends BaseBloc<LoginRequested, void> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<BaseState<void>> emit,
  ) async {
    emitLoading(emit);

    try {
      await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      emitSuccess(emit, null);
    } on AppException catch (e) {
      emitError(emit, e);
    }
  }
}
