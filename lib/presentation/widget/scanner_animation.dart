import 'package:flutter/material.dart';

class ScannerAnimation extends AnimatedWidget {
  const ScannerAnimation({
    required Animation<double> animation,
    super.key,
  }) : super(
          listenable: animation,
        );

  // static const double barHeight = 10;
  // static const double barRadius = 35;
  // static const double barResponsivePosition = 35;
  // static const double barPositionHorizontal = 15;
  // static const double opacity = 0.1;
  // static const double spreadRadius = 5;
  // static const double blurRadius = 15;
  // static const double offsetDy = 3;
  // static const double offsetDx = 0;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final valueH = MediaQuery.of(context).size.width - 30;

    final scorePosition = (animation.value * valueH);

    return Positioned(
      bottom: scorePosition,
      left: 0,
      right: 0,
      child: Container(
        height: 5, // Height represents the thickness of the line
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.red,
        ),
      ),
    );
  }
}
