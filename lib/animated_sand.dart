import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimatedSand extends AnimatedWidget {
  final _blockSize = 2.0;
  final double height;

  AnimatedSand({Key key, Animation<Offset> animation, @required this.height})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<Offset>;
    final count = (height).round();
    return Container(
      width: _blockSize * 2.0,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        overflow: Overflow.clip,
        children: <Widget>[
          SlideTransition(
            position: animation,
            child: Wrap(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.vertical,
              children: List.generate(
                count,
                (index) {
                  return Container(
                    height: _blockSize,
                    width: _blockSize,
                    color: index % 2 == 0
                        ? Colors.red
                        : Color.fromRGBO(0, 0, 0, 0.0),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
