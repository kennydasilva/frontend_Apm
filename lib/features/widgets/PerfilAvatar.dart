import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String userName;

  const ProfileAvatar({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20.0,
        backgroundColor: Colors.blueAccent,
      child: Text(
        userName.isNotEmpty ? userName[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
