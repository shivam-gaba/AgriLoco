import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Function onSubmitted;
  final TextInputType inputType;

  CustomTextField({this.hint, this.onSubmitted, this.inputType});
  @override
  Widget build(BuildContext context) {
    return BeautyTextfield(
      width: double.maxFinite,
      height: 60,
      duration: Duration(milliseconds: 300),
      backgroundColor: Colors.lightGreen.shade100,
      textColor: Colors.green.shade900,
      inputType: inputType ?? TextInputType.text,
      prefixIcon: Icon(
        Icons.filter_hdr,
      ),
      placeholder: hint,
      onChanged: onSubmitted,
      onSubmitted: onSubmitted,
    );
  }
}
