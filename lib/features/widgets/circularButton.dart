import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/App_cores.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final VoidCallback onPressed;

  const CircleButton({
    required this.icon,
    required this.iconSize,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Cores.whiteColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
            iconSize: iconSize,
            color: Cores.gradient4,
        ),
        );
   }
}