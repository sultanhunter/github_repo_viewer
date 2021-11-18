part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationStateInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateAuthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateUnauthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateError extends AuthenticationState {
  final AuthFailure authFailure;

  AuthenticationStateError({required this.authFailure});
  @override
  List<Object?> get props => [authFailure];
}
