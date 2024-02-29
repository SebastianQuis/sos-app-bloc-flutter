part of 'users_bloc.dart';

class UsersState extends Equatable {
  final bool hasUsers;
  final bool isCreatedUser;
  final List<Usuario>? listUsers;

  const UsersState({ 
    required this.hasUsers,  
    required this.isCreatedUser,
    this.listUsers
  });


  UsersState copyWith({
    bool? hasUsers,
    bool? isCreatedUser,
    List<Usuario>? listUsers
  }) {
    return UsersState(
      hasUsers: hasUsers ?? this.hasUsers, 
      isCreatedUser: isCreatedUser ?? this.isCreatedUser,
      listUsers: listUsers ?? this.listUsers
    );
  }
  
  @override
  List<Object?> get props => [hasUsers, isCreatedUser, listUsers];
}

