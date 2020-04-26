// Flutter code sample for TweenAnimationBuilder

// This example shows an [IconButton] that "zooms" in when the widget first
// builds (its size smoothly increases from 0 to 24) and whenever the button
// is pressed, it smoothly changes its size to the new target value of either
// 48 or 24.

import 'package:flutter/material.dart';

class TweenAnimationRoute extends StatefulWidget {
  TweenAnimationRoute({Key key}) : super(key: key);

  @override
  _TweenAnimationRouteState createState() => _TweenAnimationRouteState();
}

class _TweenAnimationRouteState extends State<TweenAnimationRoute> {
  double targetValue = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tween Animation Builder'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: targetValue),
          duration: Duration(seconds: 1),
          builder: (BuildContext context, double size, Widget child) {
            return IconButton(
              iconSize: size,
              color: Colors.blue,
              icon: child,
              onPressed: () {
                setState(() {
                  targetValue = targetValue == 100.0 ? 200.0 : 100.0;
                });
              },
            );
          },
          child: Icon(Icons.settings),
        ),
      ),
    );
  }
}
