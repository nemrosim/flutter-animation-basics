import 'package:animationapp/constants/routes.dart';
import 'package:animationapp/widgets/raised_app_button.dart';
import 'package:flutter/material.dart';

class ImplicitAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Implicit Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedAppButton(
              buttonText: "Animated Container",
              onPressed: () {
                Navigator.pushNamed(context,
                    '/${MAIN_ROUTES.IMPLICIT}/${IMPLICIT_ROUTES.CONTAINER}');
              },
            ),
            RaisedAppButton(
              buttonText: "Animated Opacity",
              onPressed: () {
                Navigator.pushNamed(context,
                    '/${MAIN_ROUTES.IMPLICIT}/${IMPLICIT_ROUTES.OPACITY}');
              },
            ),
            RaisedAppButton(
              buttonText: "Animated Padding",
              onPressed: () {
                Navigator.pushNamed(context,
                    '/${MAIN_ROUTES.IMPLICIT}/${IMPLICIT_ROUTES.PADDING}');
              },
            ),
            RaisedAppButton(
              buttonText: "Tween Animation Builder",
              onPressed: () {
                Navigator.pushNamed(context,
                    '/${MAIN_ROUTES.IMPLICIT}/${IMPLICIT_ROUTES.TWEEN}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
