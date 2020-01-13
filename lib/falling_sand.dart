import 'package:digital_clock/animated_sand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

class FallingSand extends StatefulWidget {
  final double maxHeight;
  FallingSand(this.maxHeight);
  @override
  _FallingSandState createState() => _FallingSandState();
}

class _FallingSandState extends State<FallingSand>
    with SingleTickerProviderStateMixin {
  Animation<Offset> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween<Offset>(begin: Offset(0, -0.1), end: const Offset(0, 0))
        .animate(controller);
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSand(
      animation: animation,
      height: widget.maxHeight,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
