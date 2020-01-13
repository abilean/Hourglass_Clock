import 'package:digital_clock/falling_sand.dart';
import 'package:flutter/material.dart';

class Sand extends StatelessWidget {
  final int maxNumber;
  final double timePercent;
  final int glassFlex;
  final int baseFlex;
  final double maxHeight;

  Sand(this.maxNumber, this.timePercent, this.glassFlex, this.baseFlex,
      this.maxHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      //Background sand
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 13,
                child: Container(),
              ),
              Expanded(
                flex: 93, //187
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
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              FallingSand(maxHeight),
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 93,
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: timePercent,
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
                  ),
                  Expanded(
                    flex: 13,
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
