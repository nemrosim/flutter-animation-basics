import 'package:flutter/material.dart';

class RaisedAppButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  RaisedAppButton({
    @required this.buttonText,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: SizedBox(
        width: 200,
        height: 50,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
            side: BorderSide(
              width: 0.2,
              style: BorderStyle.solid,
              color: Colors.blueGrey,
            ),
          ),
          onPressed: onPressed,
          elevation: 8,
          child: Text(buttonText),
        ),
      ),
    );
  }
}
