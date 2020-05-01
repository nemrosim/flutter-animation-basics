import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomDrawer_V2 extends StatefulWidget {
  @override
  _CustomDrawer_V2State createState() => _CustomDrawer_V2State();
}

class _CustomDrawer_V2State extends State<CustomDrawer_V2>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  final double maxSlide = 300.0; // current screen 375
  final double minDragStartEdge = 80.0;
  final double maxDragStartEdge = 200.0;

  bool _canBeDragged;

  ///  To determine if we can start opening or closing drawer.
  void _onDragStart(DragStartDetails details) {
//    print('Global position: ${details.globalPosition}');
    print('Media query: ${MediaQuery.of(context).size}');
//    print('Global position DX: ${details.globalPosition.dx}');
//    print('Global position DY: ${details.globalPosition.dy}');
    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  /// For calculate how big was the gesture
  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      animationController.value += delta;
    }
  }

  /// What should be done at the end of the gesture - close or open ?
  void _onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget myDrawer() {
      return Container(
        color: Colors.deepOrangeAccent,
        child: Center(
          child: SafeArea(
            child: Text(
              'Container A',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      );
    }

    Widget myChild = Container(
      color: Colors.cyan,
      child: Center(
          child: Text(
        'Container B',
        style: TextStyle(fontSize: 30),
      )),
    );

    double calculateOffsetFor_Container_A() {
      double result = maxSlide * (animationController.value - 1) - 75;
      print("Result Container A $result");
      return result;
    }

    double calculateOffsetFor_Container_B() {
      double result = maxSlide * animationController.value;
      print("Result Container B $result");
      return result;
    }

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.translucent,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Material(
            color: Colors.blueGrey,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(calculateOffsetFor_Container_A(), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: myDrawer(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(calculateOffsetFor_Container_B(), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: myChild,
                  ),
                ),
                Positioned(
                  top: 4.0 + MediaQuery.of(context).padding.top,
                  left: 4.0 + animationController.value * maxSlide,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: toggle,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 16.0 + MediaQuery.of(context).padding.top,
                  left: animationController.value *
                          MediaQuery.of(context).size.width -
                      50,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Some AppName',
                    style: Theme.of(context).primaryTextTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
