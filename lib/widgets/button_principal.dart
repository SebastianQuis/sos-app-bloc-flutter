import 'package:flutter/material.dart';

class ButtonPrincipal extends StatelessWidget {
  final Color color;
  final double paddingVertical;
  final String title;
  final void Function()? onPressed;
  const ButtonPrincipal({super.key, required this.title, required this.onPressed, this.paddingVertical = 20, this.color = Colors.indigo});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: paddingVertical),
      width: size.width * 0.7,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        onPressed: onPressed, 
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white,))
      ),
    );
  }
}
