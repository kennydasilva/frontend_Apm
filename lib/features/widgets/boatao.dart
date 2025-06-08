import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apmt/features/theme/App_cores.dart';



class Buttao extends StatelessWidget {
  final String TextoButtao;
  final VoidCallback onTap;
  const Buttao({
    super.key,
    required this.TextoButtao,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Cores.gradient4,
            Cores.gradient4,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),

      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Cores.transparentColor,
          shadowColor: Cores.transparentColor,
        ),
        child: Text(
          TextoButtao,
          style:const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
