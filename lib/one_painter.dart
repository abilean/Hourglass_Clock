import 'package:flutter/material.dart';

class OnePainter extends CustomPainter {
  final double height;
  final double width;

  OnePainter({this.height, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    // var rect = Offset.zero & size;
    // var gradient = RadialGradient(
    //   center: const Alignment(.5, -0.6),
    //   radius: 0.2,
    //   colors: [const Color(0xFFFFFFFF), const Color(0xFF00FFFF)],
    //   stops: [0.4, 1.0],
    // );
    // canvas.drawRect(
    //   rect,
    //   Paint()..shader = gradient.createShader(rect),
    // );
    final numHeight = size.height * .8;
    final numWidth = size.width * .6;
    final xOffset = size.width * .2;
    final yOffset = size.height * .1;

    var paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    var path = Path();
    path.addRect(Rect.fromLTWH(xOffset, yOffset, numWidth, numHeight / 8));
    path.addRect(Rect.fromLTWH(
        xOffset, yOffset + numHeight / 8, numWidth / 6, numHeight / 4));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
