import 'package:digital_clock/falling_sand.dart';
import 'package:flutter/material.dart';

class Sand extends StatelessWidget {
  final double timePercent;
  final int glassFlex;
  final int baseFlex;
  final bool isSpinning;

  Sand(this.timePercent, this.glassFlex, this.baseFlex, this.isSpinning);

  @override
  Widget build(BuildContext context) {
    return Column(
      //Background sand
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: baseFlex,
                child: Container(),
              ),
              Expanded(
                flex: glassFlex, //187
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 1 - timePercent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.elliptical(150, 50),
                          right: Radius.elliptical(150, 50)),
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            overflow: Overflow.clip,
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              isSpinning ? Container() : FallingSand(),
              Column(
                children: <Widget>[
                  Expanded(
                    flex: glassFlex,
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: timePercent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(50),
                            ),
                            child: Container(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: baseFlex,
                    child: Container(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
