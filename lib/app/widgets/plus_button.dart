import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final Function() onPressed;
  const PlusButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(color: Colors.grey.shade500, spreadRadius: 1.0, blurRadius: 15.0, offset: const Offset(-4.0, -4.0)),
          //   BoxShadow(color: Colors.white, spreadRadius: 1.0, blurRadius: 15.0, offset: const Offset(4.0, 4.0)),
          // ],
        ),
        child: Center(child: Text('+', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey[400]))),
      ),
    );
  }
}
