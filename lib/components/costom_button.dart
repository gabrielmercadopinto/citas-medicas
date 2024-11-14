import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double ? width;
  final double ? height;
  final FontWeight ? fontWeight;
  final Color color;
  final String text;
  final void Function()? onTap;
  const CustomButton(
    {
      super.key, 
      this.width, 
      this.height,
      this.fontWeight,
      required this.color, 
      required this.text, 
      required this.onTap
    }
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 225,
        height: height ?? 35,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
                text,
                style: TextStyle(color: Colors.white, fontWeight: (fontWeight ?? FontWeight.normal)),

          ),
        ),
      ),
    );
  }
}