import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:sos_harold_app/helpers/helpers.dart';
import 'package:sos_harold_app/models/models.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState(hasUsers: false, isCreatedUser: false)) {
    
    on<OnGetUsersEvent>((event, emit) => emit( state.copyWith(
      hasUsers: true,
      listUsers: event.listUsers
    )));
    
    on<OnCreatedUserEvent>((event, emit) => emit( state.copyWith(
      isCreatedUser: true
    )));

  }
  
  Usuario? userSelected;

  Future<String?> createUser(Usuario usuario) async {
    try {      
      final url = Uri.https(dotenv.env['BD_BASE_URL']!, 'usuarios.json');
      final rspta = await http.post(url, body: usuario.toRawJson());
      final dataDecodificada = jsonDecode(rspta.body);
      usuario.id = dataDecodificada['name'];
      add(OnCreatedUserEvent());
      return usuario.id!;  
    } catch (e) {
      return null;
    }
  }

  Future<List<Usuario>> getUserByPadre(String padre) async {
    try {
      final url = Uri.https(dotenv.env['BD_BASE_URL']!, 'usuarios.json',{
        "orderBy": '"padre"',
        "equalTo": '"$padre"',
      });

      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        final data = json.decode(respuesta.body);
        final listUsers = convertirMapaACitas(data);
        add(OnGetUsersEvent(listUsers));
        return listUsers;
      } else {
        return [];
      }
    } catch (e) {
      return  [];
    }
  }

}