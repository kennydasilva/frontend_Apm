import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {

  final IconData icon;
  final double iconSize;
  final Function onPressed;

  const CircleButton({
    required this.icon,
    required this.iconSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed.call(),
        icon: Icon(icon),
        iconSize: iconSize,
        color: Colors.black,
      ),
    );
  }
}