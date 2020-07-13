import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color color;
  final Function onPress;
  final String text;

  CustomButton({this.text, this.color, this.onPress});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: widget.color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: widget.onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            widget.text,
            softWrap: true,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
