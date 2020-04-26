import 'package:animationapp/widgets/raised_app_button.dart';
import 'package:flutter/material.dart';

class AnimatedPaddingRoute extends StatefulWidget {
  @override
  _AnimatedPaddingRouteState createState() => _AnimatedPaddingRouteState();
}

class _AnimatedPaddingRouteState extends State<AnimatedPaddingRoute> {
  bool isAnimationStarted = false;

  bool isWithDecoration = false;

  void changeAnim() async {
    setState(() {
      isAnimationStarted = true;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isAnimationStarted = false;
      });
    });
  }

  void changeDecoration() {
    setState(() {
      isWithDecoration = !isWithDecoration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Padding'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AnimatedPadding(
              padding: EdgeInsets.only(
                right: isAnimationStarted ? 0.0 : 300.0,
                left: isAnimationStarted ? 300.0 : 0.0,
              ),
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                color: isAnimationStarted ? Colors.blue : Colors.red,
                width: 100,
                height: 400,
              ),
            ),
            RaisedAppButton(
              onPressed: changeAnim,
              buttonText: 'Start animation',
            ),
          ],
        ),
      ),
    );
  }
}
