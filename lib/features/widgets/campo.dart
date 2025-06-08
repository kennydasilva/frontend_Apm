import 'package:flutter/material.dart';
import 'package:apmt/features/theme/App_cores.dart';

class Campos extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isTextoOculto;

  const Campos({
    super.key,
    required this.hintText,
    required this.controller,
    this.isTextoOculto = false,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Cores.gradient4,
        ),
      ),
      validator: (val) {
        if (val !.trim().isEmpty) {
          return "$hintText esta a faltar ";
        }

        return null;
      },
      obscureText: isTextoOculto,
    );
  }
}