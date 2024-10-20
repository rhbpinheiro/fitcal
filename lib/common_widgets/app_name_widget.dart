import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  final Color? greenTitleColor;
  final double textSize;
  const AppNameWidget({
    super.key,
    this.greenTitleColor,
    this.textSize = 30
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
          color: greenTitleColor ?? Colors.green,
          fontWeight: FontWeight.bold,
        ),
        children: [
          const TextSpan(
            text: 'Fit',
          ),
          TextSpan(
            text: 'Cal',
            style: TextStyle(
              fontSize: textSize,
              color: const Color.fromARGB(255, 255, 80, 64),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
