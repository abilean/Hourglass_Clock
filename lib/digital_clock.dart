// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
//import 'dart:html';

import 'package:digital_clock/hourglass.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Color(0xFF174EA6),
};

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      // _timer = Timer(
      //   Duration(minutes: 1) -
      //       Duration(seconds: _dateTime.second) -
      //       Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final hour = int.parse(DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh')
        .format(_dateTime));
    final minute = _dateTime.minute;
    final second = _dateTime.second;
    final hourDivider = widget.model.is24HourFormat ? 24 : 13;
    final secondPercent = (second / 60);
    final minutePercent = (minute + (second / 60)) / 60;
    final hourPercent = (hour + (minute / 60)) / hourDivider;
    // final fontSize = MediaQuery.of(context).size.height / 50;
    // final offset = fontSize / 7;
    // final defaultStyle = TextStyle(
    //   color: colors[_Element.text],
    //   fontFamily: 'PressStart2P',
    //   fontSize: fontSize,
    // shadows: [
    //   Shadow(
    //     blurRadius: 0,
    //     color: colors[_Element.shadow],
    //     offset: Offset(1, 0),
    //   ),
    // ],
    // );

    return Container(
      color: colors[_Element.background],
      child: LayoutBuilder(builder: (context, constraints) {
        print(constraints.maxHeight);
        return DefaultTextStyle(
          style: TextStyle(
            color: colors[_Element.text],
            fontFamily: 'PressStart2P',
            fontSize: constraints.maxHeight / 50,
            decoration: TextDecoration.underline,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: HourGlass(
                  backgroundColor: colors[_Element.background],
                  maxNumber: widget.model.is24HourFormat ? 24 : 13,
                  timePercent: hourPercent,
                ),
              ),
              // Flexible(
              //   fit: FlexFit.tight,
              //   child: Column(
              //     children: <Widget>[
              //       DecoratedBox(
              //         decoration: BoxDecoration(color: Colors.white),
              //       )
              //     ],
              //   ),
              // ),
              Flexible(
                fit: FlexFit.tight,
                child: HourGlass(
                  backgroundColor: colors[_Element.background],
                  maxNumber: 60,
                  timePercent: minutePercent,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: HourGlass(
                  backgroundColor: colors[_Element.background],
                  maxNumber: 60,
                  timePercent: secondPercent,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
