
import 'package:flutter/material.dart';

class NotificacionService {
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar( String message, Color color ) {
    final snackBar = SnackBar(
      content: SizedBox(
        height: 50,
        child: Align(
          alignment: Alignment.center,
          child: Text( message, style: const TextStyle( 
            color: Colors.white, fontSize: 20), textAlign: TextAlign.center, ),
        ),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      animation: CurvedAnimation(
        parent: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: const AlwaysStoppedAnimation<double>(1),
            curve: const Interval(0.4, 1.0, curve: Curves.decelerate),
          ),
        ),
        curve: Curves.linearToEaseOut,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
