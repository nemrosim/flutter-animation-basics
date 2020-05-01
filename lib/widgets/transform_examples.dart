import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformExamples extends StatefulWidget {
  @override
  _TransformExamplesState createState() => _TransformExamplesState();
}

class _TransformExamplesState extends State<TransformExamples>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  IconData _buttonIcon = Icons.play_arrow;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  void onPressedHandler() {
    if (animationController.isDismissed) {
      animationController.forward();
      setState(() {
        _buttonIcon = Icons.arrow_back;
      });
    } else {
      animationController.reverse();
      setState(() {
        _buttonIcon = Icons.play_arrow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transform"),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: MainContent(animationController),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: onPressedHandler,
        child: Icon(
          _buttonIcon,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  final AnimationController animationController;

  MainContent(this.animationController);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: this.animationController,
      child: RedContainer(),
      builder: (context, child) {
        return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.01)
            ..translate(0.9, 0.9)
            ..rotateX((45 / (180 / math.pi)) * animationController.value),
          child: child,
        );
      },
    );
  }
}

class RedContainer extends StatelessWidget {
  const RedContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.red,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'TEST',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
}
