import 'package:flutter_bloc/flutter_bloc.dart';
import '../errors/app_exception.dart';
import 'base_state.dart';
import 'base_event.dart';

abstract class BaseBloc<E extends BaseEvent, T>
    extends Bloc<E, BaseState<T>> {
  BaseBloc() : super(const InitialState());

  void emitLoading(Emitter<BaseState<T>> emit) {
    emit(const LoadingState());
  }

  void emitSuccess(Emitter<BaseState<T>> emit, T data) {
    emit(SuccessState<T>(data));
  }

  void emitError(Emitter<BaseState<T>> emit, AppException exception) {
    emit(ErrorState<T>(exception));
  }
}
