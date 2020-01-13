import 'package:digital_clock/sand.dart';
import 'package:flutter/material.dart';
import './numbers.dart';

enum Digit { hourTenth, hour, minuteTenth, minute }

class HourGlass extends StatelessWidget {
  final Color backgroundColor;
  final int maxNumber;
  final double timePercent;
  final int hour;
  final double maxHeight;

  final int _glassflex = 93;
  final int _baseflex = 13;

  HourGlass(
      {@required this.backgroundColor,
      @required this.maxNumber,
      @required this.timePercent,
      @required this.hour,
      @required this.maxHeight});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 0.463,
        child: Stack(
          children: <Widget>[
            Sand(maxNumber, timePercent, _glassflex, _baseflex, maxHeight),
            Center(
              child: Image(
                image: AssetImage("assets/hourGlassOutline.png"),
                color: backgroundColor,
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
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: _glassflex,
                      child: Numbers(maxNumber),
                    ),
                    Expanded(
                      flex: _baseflex,
                      child: Container(),
                    )
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
