import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Cube3DPage extends StatelessWidget {
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
  String velocity = '';

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
  void _onDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      this.dragDirection = "UPDATING";
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

  @override
  Widget build(BuildContext context) {
    double parseAngle() {
      if (dXPoint.length > 0) {
        double relative = 100 / double.parse(dXPoint);

        double screenWidth = 100 / MediaQuery.of(context).size.width;
      }

      double result = dXPoint.length > 0 ? 100 / double.parse(dXPoint) : 0.0;
      return result;
    }

    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStartHandler,
      onVerticalDragStart: _onVerticalDragStartHandler,
      onHorizontalDragUpdate: _onDragUpdateHandler,
      onVerticalDragUpdate: _onDragUpdateHandler,
      onHorizontalDragEnd: _onDragEnd,
      onVerticalDragEnd: _onDragEnd,
      onTap: () {},
      behavior: HitTestBehavior.translucent,
      child: Cube(dxPoint: parseAngle()),
    );
  }
}

class CubeSideData {
  double dxOffset = 0;
  double dyOffset = 0;
  double rotateY = 0;
  double rotateX = 0;
  double rotateZ = 0;
  double angle = 0;
  AlignmentGeometry alignment = Alignment.center;

  CubeSideData({
    @required this.dxOffset,
    @required this.dyOffset,
    @required this.rotateY,
    @required this.rotateX,
    @required this.rotateZ,
    @required this.angle,
    @required this.alignment,
  });
}

class Cube extends StatefulWidget {
  final double dxPoint;
  const Cube({
    Key key,
    this.dxPoint,
  }) : super(key: key);

  @override
  _CubeState createState() => _CubeState();
}

class _CubeState extends State<Cube> {
  double rotateX = 0;
  double rotateY = 0;
  double rotateZ = 0;

  String sideRotate = 'Red';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.green[100],
      child: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 200,
              child: Container(
                child: NewCube(
                  dxPoint: widget.dxPoint,
                  rotateX: rotateX,
                  rotateY: rotateY,
                  rotateZ: rotateZ,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('$sideRotate Rotate "Z"'),
                      Slider(
                        onChanged: (double value) {
                          print('ROTATE Z: $value');
                          setState(() {
                            this.rotateZ = value;
                          });
                        },
                        value: rotateZ,
                        max: 180,
                        min: -180,
                      ),
                      Text('$sideRotate Rotate "X"'),
                      Slider(
                        onChanged: (double value) {
                          print('ROTATE X: $value');
                          setState(() {
                            this.rotateX = value;
                          });
                        },
                        value: rotateX,
                        max: 180,
                        min: -180,
                      ),
                      Text('$sideRotate Rotate "Y"'),
                      Slider(
                        onChanged: (double value) {
                          print('ROTATE Y: $value');
                          setState(() {
                            this.rotateY = value;
                          });
                        },
                        value: rotateY,
                        max: 180,
                        min: -180,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewCube extends StatelessWidget {
  final double dxPoint;
  final double rotateX;
  final double rotateY;
  final double rotateZ;

  const NewCube({
    Key key,
    this.dxPoint,
    this.rotateX,
    this.rotateY,
    this.rotateZ,
  }) : super(key: key);

  double getDegAngle(double angle) {
    return (360 + angle) * (math.pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    print(dxPoint);
    double dxMove = 30.0;
    return Stack(
      children: <Widget>[
        CubeSide(
          sideColor: Colors.blue[300],
          cubeSideData: CubeSideData(
            dxOffset: dxMove,
            dyOffset: 0,
            rotateY: getDegAngle(45),
            rotateX: getDegAngle(45),
            rotateZ: 0,
            angle: 0,
            alignment: FractionalOffset.center,
          ),
        ),
        Visibility(
          visible: true,
          child: CubeSide(
            sideColor: Colors.red[300],
            cubeSideData: CubeSideData(
              dxOffset: 133.0 + dxMove,
              dyOffset: -70,
              rotateY: getDegAngle(-47),
              rotateX: getDegAngle(rotateX), // 0,
              rotateZ: getDegAngle(rotateZ), //-42,
              angle: 0,
              alignment: FractionalOffset.center,
            ),
          ),
        ),
        CubeSide(
          sideColor: Colors.green[300],
          cubeSideData: CubeSideData(
            dxOffset: 6.0 + dxMove,
            dyOffset: -138,
            rotateY: getDegAngle(53.0),
            rotateX: getDegAngle(-54.5),
            rotateZ: getDegAngle(-9.5),
            angle: 0,
            alignment: FractionalOffset.center,
          ),
        ),
      ],
    );
  }
}

class CubeSide extends StatelessWidget {
  final CubeSideData cubeSideData;
  final Color sideColor;

  const CubeSide({
    Key key,
    @required this.cubeSideData,
    @required this.sideColor,
  }) : super(key: key);

  Matrix4 getMatrix4() {
    Matrix4 result = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(cubeSideData.rotateY)
      ..rotateX(cubeSideData.rotateX)
      ..rotateZ(cubeSideData.rotateZ);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(cubeSideData.dxOffset, cubeSideData.dyOffset),
      child: Transform(
        alignment: cubeSideData.alignment,
        transform: getMatrix4(),
        child: Transform.rotate(
          angle: cubeSideData.angle,
          child: TestContainer(color: sideColor),
        ),
      ),
    );
  }
}

class TestContainer extends StatelessWidget {
  final Color color;

  TestContainer({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      child: Container(
        child: Center(
            child: Text(
          "CONTAINER",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        )),
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 1.0,
            ),
          ],
        ),
        width: 200,
        height: 200,
      ),
    );
  }
}
