import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sos_harold_app/bloc/blocs.dart';


class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({super.key});

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: CircleAvatar(
        maxRadius: 22,
        backgroundColor: Colors.grey[400],
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              onPressed: (){
                mapBloc.add(OnStartFollowUserEvent());
              }, 
              icon: Icon( 
                state.isFollowingUser ? Icons.run_circle_rounded : Icons.hail_rounded, 
                color: Colors.black87, size: 25,
              ),
            );
          }
        ),
      ),
    );
  }
}