part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class OnGetUsersEvent extends UsersEvent{
  final List<Usuario> listUsers;
  const OnGetUsersEvent(this.listUsers);
}

class OnCreatedUserEvent extends UsersEvent{}
