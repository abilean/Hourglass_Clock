import 'package:flutter/material.dart';
import './numbers.dart';

enum Digit { hourTenth, hour, minuteTenth, minute }

class HourGlass extends StatelessWidget {
  final Color backgroundColor;
  final int maxNumber;
  final double timePercent;

  HourGlass(
      {@required this.backgroundColor,
      @required this.maxNumber,
      @required this.timePercent});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 0.463,
        child: Stack(
          children: <Widget>[
            Column(
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
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 110,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          Padding(
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
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 13,
                      child: Container(),
                    ),
                  ],
                )),
              ],
            ),
            Center(
              child: Image(
                image: AssetImage("assets/hourGlassOutline.png"),
                color: backgroundColor,
              ),
            ),
            Center(
                child: Image.asset(
              "assets/hourGlass.png",
            )),
            Column(children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 93,
                      child: Numbers(maxNumber),
                    ),
                    Expanded(
                      flex: 13,
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
