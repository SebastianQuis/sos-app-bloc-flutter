import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sos_harold_app/bloc/blocs.dart';
import 'package:sos_harold_app/models/models.dart';
import 'package:sos_harold_app/screens/screens.dart';
import 'package:sos_harold_app/widgets/widgets.dart';
 
class AgregarHijoScreen extends StatelessWidget {
  static const nombre = 'AgregarHijoScreen';
  const AgregarHijoScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usersBloc = BlocProvider.of<UsersBloc>(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              
              const LogoPrincipal(height: 150),

              TitlePrincipal('Hola ${authBloc.state.userLogged!.email.split('@')[0]}'),
           
              ButtonPrincipal(
                title: 'Cerrar sesión',
                onPressed: () => Navigator.pushReplacementNamed(context, UsuarioSeleccionaScreen.nombre),
                color: Colors.red,
                paddingVertical: 5,
              ),

              ButtonPrincipal(
                title: 'Agregar hijo',
                onPressed: () {
                  Navigator.pushNamed(context, RegistroHijoScreen.nombre);
                },
                paddingVertical: 5,
              ),
                
              FutureBuilder(
                future: usersBloc.getUserByPadre(authBloc.state.userLogged!.email),
                builder: (context, snapshot) {
                  if ( snapshot.hasError) return const CircularProgressIndicator.adaptive(); 
                  if ( !snapshot.hasData ) return const CircularProgressIndicator.adaptive();
                  
                  return snapshot.data!.isEmpty
                    ? const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text('Aún no tiene a su hijo registrado', style: TextStyle(fontSize: 20, color: Colors.grey),)) 
                    : _HijosBody(snapshot.data!);
                },
                
                // _HijosBody(),
              ),
                
            ],
          ),
        ),
      ),
    );
  }
}

class _HijosBody extends StatelessWidget {
  final List<Usuario> listUser;
  const _HijosBody(this.listUser);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listUser.length,
        itemBuilder: (BuildContext context, int index) {
          
          return CardUser(user: listUser[index]);
        },
      ),
    );
  }
}

class CardUser extends StatelessWidget {
  final Usuario user;
  const CardUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final usersBloc = BlocProvider.of<UsersBloc>(context);
    
    return GestureDetector(
      onTap: () {
        usersBloc.userSelected = user;
        Navigator.pushNamed(context, BlocStateMap.nombre); 
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Card(
          color: Colors.grey[300],
          child: Container(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.snowshoeing_rounded, color: Colors.indigo, size: 30),
              title: Text('${user.nombres} ${user.apellidos}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              subtitle: Container(
                margin: const EdgeInsets.only(top: 5),
                height: 90,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Edad: ${user.edad} años'),
                    Text('DNI: ${user.dni}'),
                    Text('Celular: ${user.celular}'),
                  ],
                ),
              ),
            ),
          )),
      ),
    );
  }
}