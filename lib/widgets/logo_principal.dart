import 'package:flutter/material.dart';

class LogoPrincipal extends StatelessWidget {
  final double height;

  const LogoPrincipal({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Image(
        image: AssetImage('assets/sos_logo.png'),
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
      ),
    );
  }
}

