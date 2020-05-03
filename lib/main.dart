import 'package:animationapp/constants/routes.dart';
import 'package:animationapp/pages/3dCube/index.dart';
import 'package:animationapp/pages/scrollable_gallery/index.dart';
import 'package:animationapp/routes/explicit.dart';
import 'package:animationapp/routes/implicit.dart';
import 'package:animationapp/routes/implicit/anim_container.dart';
import 'package:animationapp/routes/implicit/anim_opacity.dart';
import 'package:animationapp/routes/implicit/anim_padding.dart';
import 'package:animationapp/routes/implicit/tween_anim.dart';
import 'package:flutter/material.dart';

import 'pages/gesture_detector/index.dart';
import 'pages/multibar/multibar.dart';
import 'widgets/custom-drawer-v2.dart';
import 'widgets/raised_app_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
//      home: MyHomePage(title: 'Flutter Animations'),
//      home: CustomDrawer(),
//      home: TransformExamples(),
//      home: SkintoneSelectorApp(),
//      home: ScrollableGallery(),
//      home: CustomDrawer_V2(),
      home: GestureDetectorPage(),
//      home: Cube3DPage(),
//      home: Multibar(),
//      home: FlightsStepper(),
      routes: {
        '/${MAIN_ROUTES.IMPLICIT}': (context) => ImplicitAnimationRoute(),
        '/${MAIN_ROUTES.IMPLICIT}/${IMPLICIT_ROUTES.CONTAINER}': (context) =>
            AnimatedContainerRoute(),
        '/${MAIN_ROUTES.IMPLICIT}/${IMPLICIT_ROUTES.OPACITY}': (context) =>
            AnimatedOpacityRoute(),
        '/${MAIN_ROUTES.IMPLICIT}/${IMPLICIT_ROUTES.TWEEN}': (context) =>
            TweenAnimationRoute(),
        '/${MAIN_ROUTES.IMPLICIT}/${IMPLICIT_ROUTES.PADDING}': (context) =>
            AnimatedPaddingRoute(),
        '/explicit': (context) => ExplicitAnimationRoute(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedAppButton(
              buttonText: "Implicit animations",
              onPressed: () {
                Navigator.pushNamed(context, '/${MAIN_ROUTES.IMPLICIT}');
              },
            ),
            RaisedAppButton(
              buttonText: 'Explicit animations',
              onPressed: () {
                Navigator.pushNamed(context, '/explicit');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
