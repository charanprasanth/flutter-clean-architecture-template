import '../errors/app_exception.dart';

abstract class BaseState<T> {
  const BaseState();
}

class InitialState<T> extends BaseState<T> {
  const InitialState();
}

class LoadingState<T> extends BaseState<T> {
  const LoadingState();
}

class SuccessState<T> extends BaseState<T> {
  final T data;
  const SuccessState(this.data);
}

class ErrorState<T> extends BaseState<T> {
  final AppException exception;
  const ErrorState(this.exception);
}
