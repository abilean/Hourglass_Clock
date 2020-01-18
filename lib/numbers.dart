import 'package:flutter/material.dart';

class Numbers extends StatelessWidget {
  final int maxValue;

  Numbers(this.maxValue);

  @override
  Widget build(BuildContext context) {
    var _spacing = 1;
    if (maxValue <= 13) {
      _spacing = 2;
    } else if (maxValue <= 24) {
      _spacing = 3;
    } else {
      _spacing = 15;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      verticalDirection: VerticalDirection.up,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        (maxValue / _spacing).round(),
        (index) {
          return index == 0
              ? Expanded(
                  child: Container(),
                )
              : Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: DefaultTextStyle.of(context).style.color,
                          ),
                        ),
                      ),
                      child: Text(
                        ' ${(index) * _spacing} ',
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
