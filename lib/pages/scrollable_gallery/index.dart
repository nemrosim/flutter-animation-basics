import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:math' as math;

final Color mainColor = Colors.grey[100];

class ScrollableGallery extends StatefulWidget {
  @override
  _ScrollableGalleryState createState() => _ScrollableGalleryState();
}

class _ScrollableGalleryState extends State<ScrollableGallery>
    with SingleTickerProviderStateMixin {
  AnimationController appBarAnimationController;
  IconData _buttonIcon = Icons.play_arrow;

  @override
  void initState() {
    super.initState();
    appBarAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  void onPressedHandler() {
    if (appBarAnimationController.isDismissed) {
      appBarAnimationController.forward();
      setState(() {
        _buttonIcon = Icons.arrow_back;
      });
    } else {
      appBarAnimationController.reverse();
      setState(() {
        _buttonIcon = Icons.play_arrow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: MainContent(appBarAnimationController),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_buttonIcon),
        onPressed: onPressedHandler,
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  final AnimationController animationController;

  MainContent(this.animationController);

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  Animation animation;

  @override
  void initState() {
    super.initState();
    this.animation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: this.widget.animationController,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: this.widget.animationController,
      builder: (context, child) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification e) {
            return true;
          },
          child: HorizontalListView(),
        );
      },
    );
  }
}

class HorizontalListView extends StatelessWidget {
  static const double CONTAINER_WIDTH = 200.0;

  const HorizontalListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification e) {
        return true;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.only(top: 200, bottom: 200),
            child: ListView(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                TestContainer(
                  paddingLeft: 30,
                  color: Colors.red,
                  width: CONTAINER_WIDTH,
                  height: CONTAINER_WIDTH,
                  paddingRight: 30,
                ),
                TestContainer(
                  paddingLeft: 30,
                  paddingRight: 30,
                  color: Colors.orange,
                  width: CONTAINER_WIDTH,
                  height: CONTAINER_WIDTH,
                ),
                TestContainer(
                  paddingLeft: 30,
                  paddingRight: 30,
                  color: Colors.yellow,
                  width: CONTAINER_WIDTH,
                  height: CONTAINER_WIDTH,
                ),
                TestContainer(
                  paddingLeft: 30,
                  paddingRight: 30,
                  color: Colors.green,
                  width: CONTAINER_WIDTH,
                  height: CONTAINER_WIDTH,
                ),
                TestContainer(
                  paddingLeft: 30,
                  paddingRight: 30,
                  color: Colors.blue,
                  width: CONTAINER_WIDTH,
                  height: CONTAINER_WIDTH,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TestContainer extends StatefulWidget {
  final Color color;
  final double width;
  final double height;
  final double paddingLeft;
  final double paddingRight;

  TestContainer(
      {Key key,
      @required this.color,
      @required this.width,
      @required this.height,
      @required this.paddingLeft,
      @required this.paddingRight});

  @override
  _TestContainerState createState() => _TestContainerState();
}

class _TestContainerState extends State<TestContainer> {
  double visibilityFraction;

  double getWidth() {
    print(this.visibilityFraction);
    if (visibilityFraction != null) {
      double result = widget.width + this.visibilityFraction * 100;
      return result;
    }
    return widget.width;
  }

  double getHeight() {
    print(this.visibilityFraction);
    if (visibilityFraction != null) {
      return widget.height + this.visibilityFraction * 10;
    }
    return widget.height;
  }

  @override
  Widget build(BuildContext context) {
    print('RedContainer: ${ModalRoute.of(context).isCurrent}');

    return VisibilityDetector(
      key: Key('@test.container${widget.color}'),
      onVisibilityChanged: (VisibilityInfo info) {
        setState(() {
          this.visibilityFraction = info.visibleFraction;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: widget.paddingLeft,
            right: widget.paddingRight,
            top: 5,
            bottom: 7),
        child: ConstrainedBox(
          constraints: new BoxConstraints(
            maxHeight: 800,
            maxWidth: 300,
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: widget.color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            width: getWidth(),
            height: 500,
          ),
        ),
      ),
    );
  }
}
