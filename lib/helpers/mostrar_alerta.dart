import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


mostrarAlerta( BuildContext context, String titulo){

  if( Platform.isAndroid ) {
    return showDialog(
      context: context, 
      builder: (context) => 
        AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            color: Colors.red,
            height: 90,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // backgroundColor: Colors.grey,
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              elevation: 5,
              child: const Text('Ok'),
            )
          ],
        )
    );
  }

}