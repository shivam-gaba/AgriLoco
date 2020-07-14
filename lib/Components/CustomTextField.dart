import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Function onSubmitted;

  CustomTextField({this.hint, this.onSubmitted});
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
      placeholder: hint,
      onChanged: onSubmitted,
      onSubmitted: onSubmitted,
    );
  }
}
