part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLogged;
  final LoginResponse? userLogged;
  final bool isCreatedUser;
  
  const AuthState({
    required this.isLogged, 
    this.userLogged,
    required this.isCreatedUser,
  });

  AuthState copyWith({
    bool? isLogged,
    LoginResponse? userLogged,
    bool? isCreatedUser
  }) {
    return AuthState(
      isLogged: isLogged ?? this.isLogged,
      userLogged: userLogged ?? this.userLogged,
      isCreatedUser: isCreatedUser ?? this.isCreatedUser,
    );
  }
  
  @override
  List<Object?> get props => [isLogged, userLogged, isCreatedUser];

}

