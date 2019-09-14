import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  @override
  String text;
  bool showProgress;
  Function onPressed;

  AppButton(this.text, {this.onPressed, this.showProgress = false});

  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.deepPurpleAccent,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
        onPressed: onPressed,
      ),
    );
  }
}
