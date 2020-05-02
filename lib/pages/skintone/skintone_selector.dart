import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'widgets/app-bar.dart';

final Color mainColor = Colors.grey[100];

class SkintoneSelectorApp extends StatefulWidget {
  @override
  _SkintoneSelectorAppState createState() => _SkintoneSelectorAppState();
}

class _SkintoneSelectorAppState extends State<SkintoneSelectorApp>
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
        width: double.infinity,
        height: double.infinity,
        child: MainContent(appBarAnimationController),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: onPressedHandler,
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  final AnimationController animationController;

  MainContent(this.animationController);

  Animation getAppBarAnimation() {
    return Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: this.animationController,
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
      animation: this.animationController,
      child: Container(),
      builder: (context, child) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            BodyContainer(animationController),
            MakupAppBar(animationController),
          ],
        );
      },
    );
  }
}

class BodyContainer extends StatefulWidget {
  final AnimationController animationController;

  BodyContainer(this.animationController);

  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  Animation animation;
  @override
  void initState() {
    super.initState();
    this.animation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
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
    return Positioned(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      top: 0.0,
      child: Container(
        color: Colors.lightBlue[100],
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Stack(
            children: <Widget>[
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: 10,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Text(
                      'Choose your skintone',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: 60,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 30, bottom: 30, left: 20, right: 20),
                    child: Text(
                      'Get more accurate listings by tailoring it to your skintone',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                height: 300,
                top: 180,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification e) {
//                    print(e);
                    return true;
                  },
                  child: HorizontalListView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalListView extends StatelessWidget {
  const HorizontalListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      print('Constraints $constraints');
      return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
//                  physics: PageScrollPhysics(),
        children: <Widget>[
          RedContainer(
            color: Colors.red,
          ),
          RedContainer(
            color: Colors.green,
          ),
          RedContainer(
            color: Colors.blue,
          ),
          RedContainer(
            color: Colors.yellow,
          ),
        ],
      );
    });
  }
}

class RedContainer extends StatelessWidget {
  final Color color;

  RedContainer({@required this.color});

  @override
  Widget build(BuildContext context) {
    print('RedContainer: ${ModalRoute.of(context).isCurrent}');
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 5.0,
            ),
          ],
        ),
        width: 250,
        height: 80,
      ),
    );
  }
}
