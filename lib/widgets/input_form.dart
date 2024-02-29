import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputForm extends StatelessWidget {
  TextInputType textInputType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  String? hintText;
  String? labelText;
  Widget? suffixIcon;
  String? helperText;
  bool? enabled;
  String? initialValue;
  

  InputForm({
    super.key, 
    this.textInputType = TextInputType.name, 
    this.obscureText = false, 
    this.onChanged, 
    this.validator, 
    this.hintText, 
    this.labelText, 
    this.suffixIcon,
    this.enabled = true,
    this.initialValue,
    this.helperText
  });

  @override
  Widget build(BuildContext context) {
    // final focusNode = FocusNode();

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextFormField(
        autocorrect: false,
        enabled: enabled,
        keyboardType: textInputType,
        obscureText: obscureText,
        textCapitalization: TextCapitalization.words,
        onChanged: onChanged,
        validator: validator,
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.indigo),
          helperText: helperText,
          suffixIcon: suffixIcon,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black), // Cambia el color a rojo
          ),
        ),
      ),
    );
    
  }
}