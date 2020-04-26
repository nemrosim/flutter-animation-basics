import 'package:animationapp/widgets/raised_app_button.dart';
import 'package:flutter/material.dart';

class AnimatedContainerRoute extends StatefulWidget {
  @override
  _AnimatedContainerRouteState createState() => _AnimatedContainerRouteState();
}

class _AnimatedContainerRouteState extends State<AnimatedContainerRoute> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: AnimatedContainer(
              decoration: isWithDecoration
                  ? BoxDecoration(
                      gradient: RadialGradient(
                        colors: [Colors.purple, Colors.transparent],
                        stops: [0.9, 1.0],
                      ),
                    )
                  : null,
              color: !isWithDecoration ? Colors.red : null,
              curve: Curves.decelerate,
              width: isAnimationStarted ? 100 : 200,
              height: 300,
              child: Center(
                child: Text('Container'),
              ),
              duration: Duration(milliseconds: 500),
            ),
          ),
          Column(
            children: <Widget>[
              RaisedAppButton(
                onPressed: changeAnim,
                buttonText: 'Start animation',
              ),
              RaisedAppButton(
                onPressed: changeDecoration,
                buttonText:
                    isWithDecoration ? 'Remove decoration' : 'Add decoration',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
