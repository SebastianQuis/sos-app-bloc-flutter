import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:sos_harold_app/models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(isCreatedUser: false, isLogged: false)) {
    on<OnLoginAuthEvent>((event, emit) => emit( state.copyWith(
      isLogged: true,
      userLogged: event.userLogged,
    )));

    on<OnCreatedNewUserEvent>((event, emit) => emit( state.copyWith(
      isCreatedUser: true
    )));
  }

  final String _baseURL = 'identitytoolkit.googleapis.com';

  String typeUser = '';

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> autenticacionData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseURL, 'v1/accounts:signInWithPassword', {
      'key': dotenv.env['TOKEN_FIREBASE'], 
    });

    final respuesta = await http.post(url, body: json.encode(autenticacionData));
    final Map<String, dynamic> respuestaDecodificada = json.decode(respuesta.body);
    
    if (respuestaDecodificada.containsKey('idToken')) {
      add( OnLoginAuthEvent(userLogged: LoginResponse.fromJson(respuestaDecodificada)) );
      return null;
    } else {
      return respuestaDecodificada['error']['message'];
    }
  }

  Future<String?> createUser( String email, String password) async {
    final Map<String, dynamic> authData = {
      'email' : email,
      'password' : password
    };

    final url = Uri.https(_baseURL, '/v1/accounts:signUp', {
      'key': dotenv.env['TOKEN_FIREBASE'], 
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) { 
      add(OnCreatedNewUserEvent());
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }


}
