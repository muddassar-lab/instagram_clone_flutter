part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List get props => [];
}

class Authenticated extends AuthState {
  final User user;
  Authenticated({required this.user});

  @override
  List get props => [user];
}

class UnAuthenticated extends AuthState {
  @override
  List get props => [];
}

class AuthLoading extends AuthState {
  @override
  List get props => [];
}
