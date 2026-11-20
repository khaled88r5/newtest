import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    required this.txt,
    this.icon,
    required this.fillColor,
    this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final Text txt;
  final Icon? icon;
  final Color fillColor;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            else ...[
              icon ?? const SizedBox.shrink(),
              const SizedBox(width: 10),
              txt,
            ],
          ],
        ),
      ),
    );
  }
}