import 'package:flutter/material.dart';

import 'package:sos_harold_app/screens/screens.dart';

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({ super.key });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, OpcionesPadreScreen.nombre),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 5,
                offset: Offset(0, 2)
              ),
            ]
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Text('Más opciones..', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)),
        ),
      ),
    );
  }
}