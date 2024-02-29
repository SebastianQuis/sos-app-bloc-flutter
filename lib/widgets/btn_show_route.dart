import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sos_harold_app/bloc/blocs.dart';

class BtnShowRoute extends StatelessWidget {
  const BtnShowRoute({super.key});

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: CircleAvatar(
        maxRadius: 22,
        backgroundColor: Colors.grey[400],
        child: IconButton(
          onPressed: (){
            mapBloc.add(OnToggleShowRouteEvent());
          },
          icon: const Icon( Icons.polyline, color: Colors.black87, size: 25,
          ),
        ),
      ),
    );
  }
}