import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColorizeAnimatedTextKit(
        text: ['AGRI-LOCO'],
        repeatForever: true,
        colors: <Color>[
          Colors.green.shade900,
          Colors.greenAccent,
          Colors.greenAccent,
          Colors.green.shade900,
        ],
        textAlign: TextAlign.center,
        alignment: AlignmentDirectional.topStart,
        textStyle: TextStyle(
          fontSize: 55,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
