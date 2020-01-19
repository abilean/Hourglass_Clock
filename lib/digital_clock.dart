// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
//import 'dart:html';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './hourglass.dart';

enum _Element {
  background,
  text,
  sand,
}

final _lightTheme = {
  _Element.background: Colors.lightBlue, //Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.sand: Colors.red,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.sand: Colors.purple,
};

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock>
    with SingleTickerProviderStateMixin {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  Animation<double> _hgRotateAnimation;
  Animation<double> _hgScaleAnimation;
  AnimationController _hgController;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();

    _hgController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _hgRotateAnimation = Tween<double>(begin: 0, end: 3).animate(_hgController);
    _hgScaleAnimation = Tween<double>(begin: 1, end: 0).animate(_hgController);
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
    _hgController.dispose();
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

      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      if (_dateTime.minute == 59 &&
          _dateTime.second > 54 &&
          !_hgController.isAnimating) {
        _hgController.forward();
      } else if (_dateTime.minute == 0 &&
          _dateTime.second < 5 &&
          !_hgController.isAnimating) {
        _hgController.reverse();
      }
    });
  }

  Widget _weatherIcon() {
    switch (widget.model.weatherCondition) {
      case WeatherCondition.sunny:
        return Icon(Icons.wb_sunny);
        break;
      case WeatherCondition.foggy:
      case WeatherCondition.cloudy:
        return Icon(Icons.wb_cloudy);
        break;

      case WeatherCondition.thunderstorm:
      case WeatherCondition.rainy:
        return Icon(Icons.beach_access);
        break;
      case WeatherCondition.snowy:
        return Icon(Icons.ac_unit);
        break;

      default:
        return Icon(Icons.wb_sunny);
    }
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
    final minutePercent = (minute + (second / 60)) / 60;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Theme(
          data: ThemeData(
            primaryColor: colors[_Element.background],
            accentColor: colors[_Element.sand],
            iconTheme: IconThemeData(
              size: constraints.maxHeight / 9,
              color: colors[_Element.text],
            ),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: colors[_Element.text],
              fontFamily: 'LobsterTwo',
              fontSize: constraints.maxHeight / 30,
            ),
            child: Container(
              color: colors[_Element.background],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Center(
                        child: _weatherIcon(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RotationTransition(
                      turns: _hgRotateAnimation,
                      child: ScaleTransition(
                        scale: _hgScaleAnimation,
                        child: HourGlass(
                          maxNumber: 60,
                          timePercent: minutePercent,
                          hour: hour,
                          isSpinning: _hgController.isAnimating,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                          child: Text(
                        widget.model.temperatureString,
                        style: TextStyle(
                            fontSize:
                                DefaultTextStyle.of(context).style.fontSize *
                                    2),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
