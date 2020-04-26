import 'package:animationapp/widgets/raised_app_button.dart';
import 'package:flutter/material.dart';

class AnimatedOpacityRoute extends StatefulWidget {
  @override
  _AnimatedOpacityRouteState createState() => _AnimatedOpacityRouteState();
}

class _AnimatedOpacityRouteState extends State<AnimatedOpacityRoute> {
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
        title: Text('Animated Container'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: isAnimationStarted ? 0.01 : 1.0,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Container(
                color: Colors.red,
                width: 200,
                height: 200,
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
