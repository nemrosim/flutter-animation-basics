import 'package:flutter/material.dart';

class MakupAppBar extends StatefulWidget {
  final AnimationController animationController;

  MakupAppBar(this.animationController);

  @override
  _MakupAppBarState createState() => _MakupAppBarState();
}

class _MakupAppBarState extends State<MakupAppBar> {
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
      right: 0.0,
      top: -100.0 * animation.value,
//      top: 0.0,
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.red,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 60, bottom: 15),
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
    );
  }
}
