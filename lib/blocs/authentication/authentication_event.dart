part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class UserLoggedIn extends AuthenticationEvent {
  final User user;
  const UserLoggedIn({required this.user});
  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AuthenticationEvent {}
