import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

class FallingSand extends StatefulWidget {
  FallingSand();
  @override
  _FallingSandState createState() => _FallingSandState();
}

class _FallingSandState extends State<FallingSand>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _animation;
  AnimationController _controller;
  final _blockSize = 2.0;
  final _random = new Random(DateTime.now().millisecondsSinceEpoch);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<Offset>(begin: Offset(0, -0.1), end: const Offset(0, 0))
        .animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = MediaQuery.of(context).size.height.round();

    return Container(
      width: _blockSize * 2.0,
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: SlideTransition(
          position: _animation,
          child: Wrap(
            children: List.generate(
              count,
              (index) {
                return Opacity(
                  opacity: index % 2 == 0
                      ? _random.nextDouble()
                      : _random.nextDouble() > 0.5 ? 0 : 0.2,
                  child: Container(
                    height: _blockSize,
                    width: _blockSize,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
