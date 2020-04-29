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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multibar"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            StackWidget(animationController),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          if (animationController.value == 0) {
            animationController.forward(from: 0);
          } else {
            animationController.animateBack(0);
          }
        },
        child: Icon(Icons.account_circle),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 40.0,
        ),
      ),
    );
  }
}

class StackWidget extends StatefulWidget {
  AnimationController animationController;

  StackWidget(this.animationController);

  @override
  _StackWidgetState createState() => _StackWidgetState();
}

class _StackWidgetState extends State<StackWidget> {
  double _iconSize = 65.0;
  Animation delayedAnimation;

  @override
  void initState() {
    super.initState();
  }

  double moveTo(double value) {
    return value * widget.animationController.value;
  }

  @override
  Widget build(BuildContext context) {
    double rightCenter = MediaQuery.of(context).size.width / 2 - _iconSize / 2;
    double bottomCenter = -_iconSize / 2;

    delayedAnimation = Tween(begin: rightCenter, end: bottomCenter).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    double start = 610;
    double right = 140;
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, _) {
          return Stack(
            children: <Widget>[
              MovableIcon(
                right: right,
                left: start,
                rightEnd: 100,
                leftEnd: 40,
                animation: Tween(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval(
                      0.60,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                ),
              ),
              MovableIcon(
                right: right,
                left: start,
                rightEnd: 60,
                leftEnd: 90,
                animation: Tween(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval(
                      0.45,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                ),
              ),
              MovableIcon(
                right: right,
                left: start,
                rightEnd: 0,
                leftEnd: 110,
                animation: Tween(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval(
                      0.30,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                ),
              ),
              MovableIcon(
                right: right,
                left: start,
                rightEnd: -60,
                leftEnd: 90,
                animation: Tween(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval(
                      0.15,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                ),
              ),
              MovableIcon(
                right: right,
                left: start,
                rightEnd: -100,
                leftEnd: 40,
                animation: Tween(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval(
                      0.0,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}

class MovableIcon extends StatelessWidget {
  double right;
  double left;

  double rightEnd;
  double leftEnd;

  Animation animation;

  MovableIcon(
      {this.right, this.left, this.rightEnd, this.leftEnd, this.animation});

  @override
  Widget build(BuildContext context) {
    double iconSize = 45.0;

    return Transform(
      transform: Matrix4.translationValues(right - rightEnd * animation.value,
          left - leftEnd * animation.value, 0),
      child: RaisedButton(
        onPressed: () {},
        shape: CircleBorder(),
        elevation: 5 * animation.value,
        child: Icon(
          Icons.security,
          color: Colors.blueGrey,
          size: iconSize,
        ),
      ),
    );
  }
}
