import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.buttonText,
    required this.onPress,
  }) : super(key: key);
  final String buttonText;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    var border = const BorderSide(color: Colors.transparent, width: 3);
    Color textColor = Colors.white;
    Color backgroundColor = Colors.black;
    return buildButton(onPress, buttonText, border, textColor, backgroundColor);
    // return SizedBox(
    //   height: getProportionateScreenHeight(50),
    //   width: getProportionateScreenWidth(230),
    //   child: TextButton(
    //     onPressed: onPress as void Function()?,
    //     style: TextButton.styleFrom(
    //       textStyle: TextStyle(
    //         fontSize: getProportionateScreenHeight(20),
    //         //color: Colors.white,
    //       ),
    //       primary: Colors.white,
    //       backgroundColor: Colors.black,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(30),
    //       ),
    //     ),
    //     child: Text(
    //       buttonText,
    //       // style: TextStyle(
    //       //   fontSize: getProportionateScreenWidth(22),
    //       //   color: Colors.white,
    //       // ),
    //     ),
    //   ),
    // );
  }
}

class DefaultButtonTransparent extends StatelessWidget {
  const DefaultButtonTransparent({
    Key? key,
    required this.buttonText,
    required this.onPress,
  }) : super(key: key);
  final String buttonText;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    var border = const BorderSide(color: Colors.black, width: 3);
    Color textColor = Colors.black;
    Color backgroundColor = Colors.white;
    return buildButton(onPress, buttonText, border, textColor, backgroundColor);
  }
}

SizedBox buildButton(onPress, buttonText, border, textColor, backgroundColor) {
  return SizedBox(
    height: getProportionateScreenHeight(50),
    width: getProportionateScreenWidth(230),
    child: TextButton(
      onPressed: onPress as void Function()?,
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontFamily: 'VarelaRound',
          fontSize: 15,
        ),
        primary: textColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: border,
        ),
      ),
      child: Text(
        buttonText,
      ),
    ),
  );
}
