import 'package:flutter/material.dart';

class TitlePrincipal extends StatelessWidget {
  final String title;
  const TitlePrincipal(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10 ),
      child: Text(title,style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
    );
  }
}