import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  String title;
  VoidCallback ontap;
  Color color;
  Box(
      {super.key,
      required this.ontap,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: color),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
