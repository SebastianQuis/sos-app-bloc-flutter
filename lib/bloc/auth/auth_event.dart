part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnLoginAuthEvent extends AuthEvent{
  final LoginResponse userLogged;
  const OnLoginAuthEvent({required this.userLogged}); 
}

class OnCreatedNewUserEvent extends AuthEvent{}