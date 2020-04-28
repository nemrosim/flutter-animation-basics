import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  final double maxSlide = 255.0;
  final double minDragStartEdge = 80.0;
  final double maxDragStartEdge = 100.0;

  bool _canBeDragged;

  ///  To determine if we can start opening or closing drawer.
  void _onDragStart(DragStartDetails details) {
    print('Global position: ${details.globalPosition}');
    print('Global position DX: ${details.globalPosition.dx}');
    print('Global position DY: ${details.globalPosition.dy}');
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
      print("Close");
//      close();
      toggle();
    } else {
      print('Open');
//      open();
      toggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget myDrawer = Container(
      color: Colors.blue,
    );
    Widget myChild = Container(
      color: Colors.yellow,
    );

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double slide = maxSlide * animationController.value;
          double scale = 1 - animationController.value * 0.3;
          return Stack(
            children: <Widget>[
              myDrawer,
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: myChild,
              ),
            ],
          );
        },
      ),
    );
  }
}
