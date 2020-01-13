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
                      child: Text(' ${(index) * _spacing} ')));
        },
      ),
    );

    // switch (maxValue) {
    //   case 1:
    //     {
    //       return Column(
    //         children: <Widget>[
    //           Expanded(
    //               flex: 3,
    //               child: Align(
    //                 alignment: Alignment.bottomCenter,
    //                 child: Text(" 1 "),
    //               )),
    //           Expanded(
    //             flex: 9,
    //             child: Container(),
    //           )
    //         ],
    //       );
    //     }
    //     break;
    //   case 2:
    //     {
    //       return Column(
    //         children: <Widget>[
    //           Expanded(
    //             flex: 5,
    //             child: Align(
    //               alignment: Alignment.bottomCenter,
    //               child: Text(" 2 "),
    //             ),
    //           ),
    //           Expanded(
    //             flex: 10,
    //             child: Align(
    //               alignment: Alignment.bottomCenter,
    //               child: Text(" 1 "),
    //             ),
    //           ),
    //           Expanded(
    //             flex: 9,
    //             child: Container(),
    //           )
    //         ],
    //       );
    //     }
    //     break;
    //   default:
    //     {
    //       return Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         verticalDirection: VerticalDirection.up,
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: List.generate(
    //           maxValue,
    //           (index) {
    //             return Align(
    //                 alignment: Alignment.bottomCenter,
    //                 child: Text(' ${index + 1} '));
    //           },
    //         ),
    //       );
    //     }
    //     break;
    // }
  }
}
