import 'package:flutter/material.dart';

class SocialLoginIcon extends StatelessWidget {
  final String iconPath;

  const SocialLoginIcon({required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(216, 5, 5, 5).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(iconPath),
      ),
    );
  }
}
