import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GestureDetectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        height: double.infinity,
        child: MainContent(),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  String dragDirection = '';
  String dXPoint = '';
  String dYPoint = '';

  String dXPointONE = '';
  String dYPointONE = '';
  String dXPointTWO = '';
  String dYPointTWO = '';
  String distance = '';

  String velocity = '';
  bool showCube = false;
  bool showScale = true;

  /// Track starting point of a horizontal gesture
  void _onHorizontalDragStartHandler(DragStartDetails details) {
    setState(() {
      this.dragDirection = "HORIZONTAL";
      this.dXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.dYPoint = '${details.globalPosition.dy.floorToDouble()}';
      this.velocity = '';
    });
  }

  /// Track starting point of a vertical gesture
  void _onVerticalDragStartHandler(DragStartDetails details) {
    setState(() {
      this.dragDirection = "VERTICAL";
      this.dXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.dYPoint = '${details.globalPosition.dy.floorToDouble()}';
      this.velocity = '';
    });
  }

  /// Track current point of a gesture
  void _onHorizontalDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      this.dragDirection = "HORIZONTAL UPDATING";
      this.dXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.dYPoint = '${details.globalPosition.dy.floorToDouble()}';
      this.velocity = '';
    });
  }

  /// Track current point of a gesture
  void _onVerticalDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      this.dragDirection = "VERTICAL UPDATING";
      this.dXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.dYPoint = '${details.globalPosition.dy.floorToDouble()}';
      this.velocity = '';
    });
  }

  /// What should be done at the end of the gesture ?
  void _onDragEnd(DragEndDetails details) {
    double result = details.velocity.pixelsPerSecond.dx.abs().floorToDouble();
    setState(() {
      this.velocity = '$result';
    });
  }

//  void _onScaleStartHandler(ScaleStartDetails details) {
//    print('DISTANCE ${details}');
//    setState(() {
//      this.distance = '${details.focalPoint.distanceSquared.floorToDouble()}';
//    });
////    print('LOCAL FOCAL ${details.localFocalPoint}');
//  }

  void _onScaleUpdateHandler(ScaleUpdateDetails details) {
    double deg = details.rotation.abs() * (180 / math.pi);
    setState(() {
      this.distance = '${deg.toStringAsFixed(1)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tap');
      },
      onDoubleTap: () {
        print("DOUBLE TAB");
      },
      onLongPress: () {
        print("Long press");
      },
      onHorizontalDragStart: _onHorizontalDragStartHandler,
//      onVerticalDragStart: _onVerticalDragStartHandler,
      onHorizontalDragUpdate: _onHorizontalDragUpdateHandler,
//      onVerticalDragUpdate: _onVerticalDragUpdateHandler,
      onHorizontalDragEnd: _onDragEnd,
//      onVerticalDragEnd: _onDragEnd,
//      onScaleStart: _onScaleStartHandler,
      onScaleUpdate: _onScaleUpdateHandler,
      onScaleEnd: (ScaleEndDetails details) {},
      dragStartBehavior: DragStartBehavior.start, // default
      behavior: HitTestBehavior.translucent,
      child: !showScale
          ? StartUpdateOrVelocity(
              velocity: velocity,
              dragDirection: dragDirection,
              dXPoint: dXPoint,
              dYPoint: dYPoint,
            )
          : PinchDetailsContainer(
              dXPointONE: dXPointONE,
              dYPointONE: dYPointONE,
              dXPointTWO: dXPointTWO,
              dYPointTWO: dYPointTWO,
              distance: distance,
            ),
    );

    return Stack(
      children: <Widget>[
        GestureDetector(
          onHorizontalDragStart: _onHorizontalDragStartHandler,
          onVerticalDragStart: _onVerticalDragStartHandler,
          onHorizontalDragUpdate: _onHorizontalDragUpdateHandler,
          onVerticalDragUpdate: _onVerticalDragUpdateHandler,
          onHorizontalDragEnd: _onDragEnd,
          onVerticalDragEnd: _onDragEnd,
          dragStartBehavior: DragStartBehavior.start, // default
          onDoubleTap: () {
            print("DOUBLE TAB");
          },
          onTap: () {},
          onLongPress: () {
            print("Long press");
          },
          behavior: HitTestBehavior.translucent,
          child: StartUpdateOrVelocity(
            velocity: velocity,
            dragDirection: dragDirection,
            dXPoint: dXPoint,
            dYPoint: dYPoint,
          ),
        ),
      ],
    );
  }
}

class PinchDetailsContainer extends StatelessWidget {
  final String dXPointONE;
  final String dYPointONE;

  final String dXPointTWO;
  final String dYPointTWO;

  final String distance;
  const PinchDetailsContainer({
    Key key,
    @required this.dXPointONE,
    @required this.dYPointONE,
    @required this.dXPointTWO,
    @required this.dYPointTWO,
    @required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SCALE: ${this.distance}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StartUpdateOrVelocity extends StatelessWidget {
  final bool showVelocity = false;
  const StartUpdateOrVelocity({
    Key key,
    @required this.velocity,
    @required this.dragDirection,
    @required this.dXPoint,
    @required this.dYPoint,
  }) : super(key: key);

  final String velocity;
  final String dragDirection;
  final String dXPoint;
  final String dYPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
        child: velocity.length != 0 && showVelocity
            ? Text(
                this.velocity,
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w700,
                ),
              )
            : StartAndUpdateInfo(
                dragDirection: dragDirection,
                startDXPoint: dXPoint,
                startDYPoint: dYPoint),
      ),
    );
  }
}

class StartAndUpdateInfo extends StatelessWidget {
  const StartAndUpdateInfo({
    Key key,
    @required this.dragDirection,
    @required this.startDXPoint,
    @required this.startDYPoint,
  }) : super(key: key);

  final String dragDirection;
  final String startDXPoint;
  final String startDYPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.dragDirection,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Start DX point: ${this.startDXPoint}',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Start DY point: ${this.startDYPoint}',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        RaisedButton(
          onLongPress: () {},
          onPressed: () {
            print('Button pressed');
          },
          child: Text("CLICK ME"),
        ),
      ],
    );
  }
}
