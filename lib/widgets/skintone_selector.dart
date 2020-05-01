import 'package:flutter/material.dart';
import 'dart:math' as math;

final Color mainColor = Colors.grey[100];

class SkintoneSelector extends StatefulWidget {
  @override
  _SkintoneSelectorState createState() => _SkintoneSelectorState();
}

class _SkintoneSelectorState extends State<SkintoneSelector>
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
          children: <Widget>[
            Positioned(
              right: 0.0,
              top: -100.0 * getAppBarAnimation().value,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 90,
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: Text(
                            'Makup',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 46,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 100.0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: Container(
                  color: mainColor,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        width: MediaQuery.of(context).size.width,
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
                      Center(
                        child: Text(
                            'Get more accurate listings by tailoring it to your skintone'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
