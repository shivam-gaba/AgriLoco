import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Function onSubmitted;

  CustomTextField({this.hint, this.onSubmitted});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return BeautyTextfield(
      width: double.maxFinite,
      height: 60,
      duration: Duration(milliseconds: 300),
      backgroundColor: Colors.lightGreen.shade100,
      textColor: Colors.green.shade900,
      inputType: TextInputType.text,
      prefixIcon: Icon(
        Icons.filter_hdr,
      ),
      placeholder: widget.hint,
      onChanged: widget.onSubmitted,
      onSubmitted: widget.onSubmitted,
    );
  }
}
