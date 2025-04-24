import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback function;
  final double? hight;
  final double? width;

  const MainButton({
    super.key,
    required this.label,
    required this.function,
    this.color,
    this.hight,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight ?? 56,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          20.2,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          label,
        ),
      ),
    );
  }
}
