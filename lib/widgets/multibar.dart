import 'package:flutter/material.dart';

class Multibar extends StatefulWidget {
  @override
  _MultibarState createState() => _MultibarState();
}

class _MultibarState extends State<Multibar>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  void onPressedHandler() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multibar"),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: IconsStackWidget(animationController),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: onPressedHandler,
        child: Icon(
          Icons.settings,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 40.0,
        ),
      ),
    );
  }
}

class IconsStackWidget extends StatelessWidget {
  final AnimationController animationController;

  static const double RIGHT_END_POINT = 100;
  static const double SECOND_RIGHT_END_POINT = 60;
  static const double TOP_END_POINT = 40;
  static const double SECOND_TOP_END_POINT = 90;

  IconsStackWidget(this.animationController);

  Animation getDelayedAnimation(double delay) {
    return Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: this.animationController,
        curve: Interval(
          delay,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: this.animationController,
        builder: (context, _) {
          return Stack(
            children: <Widget>[
              MovableIcon(
                rightEnd: RIGHT_END_POINT,
                topEnd: TOP_END_POINT,
                animation: getDelayedAnimation(0.60),
              ),
              MovableIcon(
                rightEnd: SECOND_RIGHT_END_POINT,
                topEnd: SECOND_TOP_END_POINT,
                animation: getDelayedAnimation(0.45),
              ),
              MovableIcon(
                rightEnd: 0,
                topEnd: 115,
                animation: getDelayedAnimation(0.30),
              ),
              MovableIcon(
                rightEnd: -SECOND_RIGHT_END_POINT,
                topEnd: SECOND_TOP_END_POINT,
                animation: getDelayedAnimation(0.15),
              ),
              MovableIcon(
                rightEnd: -RIGHT_END_POINT,
                topEnd: TOP_END_POINT,
                animation: getDelayedAnimation(0.00),
              )
            ],
          );
        });
  }
}

class MovableIcon extends StatelessWidget {
  final double rightEnd;
  final double topEnd;

  final Animation animation;

  MovableIcon({this.rightEnd, this.topEnd, this.animation});

  @override
  Widget build(BuildContext context) {
    double topStart = 610;
    double rightStart = 143;

    return Transform(
      transform: Matrix4.translationValues(
          rightStart - rightEnd * animation.value,
          topStart - topEnd * animation.value,
          0),
      child: SizedBox(
        height: 54,
        child: RaisedButton(
          onPressed: () {},
          shape: CircleBorder(),
          elevation: 5 * animation.value,
          color: Colors.yellow,
          child: Icon(
            Icons.security,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    );
  }
}
