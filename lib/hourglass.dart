import 'package:digital_clock/falling_sand.dart';
import 'package:flutter/material.dart';
import './numbers.dart';

enum Digit { hourTenth, hour, minuteTenth, minute }

class HourGlass extends StatelessWidget {
  final int maxNumber;
  final double timePercent;
  final int hour;

  final bool isSpinning;

  final int _glassFlex = 93;
  final int _baseFlex = 13;

  HourGlass(
      {@required this.maxNumber,
      @required this.timePercent,
      @required this.hour,
      this.isSpinning});

  Widget _sand(BuildContext context) {
    return Column(
      //Background sand
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: _baseFlex,
                child: Container(),
              ),
              Expanded(
                flex: _glassFlex,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 1 - timePercent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                      child: Container(
                        color: Theme.of(context).accentColor,
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
              isSpinning
                  ? Container()
                  : FallingSand(
                      sandColor: Theme.of(context).accentColor,
                    ),
              Column(
                children: <Widget>[
                  Expanded(
                    flex: _glassFlex,
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: timePercent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(130),
                            ),
                            child: Container(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: _baseFlex,
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

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 0.463,
        child: Stack(
          children: <Widget>[
            _sand(context),
            Center(
              child: Image(
                image: AssetImage("assets/hourGlassOutline.png"),
                color: Theme.of(context).primaryColor,
              ),
            ),
            Center(
              child: Image.asset(
                "assets/hourGlass.png",
              ),
            ),
            Column(//forground numbers
                children: [
              Expanded(
                child: Center(
                  child: Text(
                    '$hour',
                    style: TextStyle(
                      fontSize:
                          DefaultTextStyle.of(context).style.fontSize * 8.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: _glassFlex,
                      child: Numbers(maxNumber),
                    ),
                    Expanded(
                      flex: _baseFlex,
                      child: Container(),
                    ),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
