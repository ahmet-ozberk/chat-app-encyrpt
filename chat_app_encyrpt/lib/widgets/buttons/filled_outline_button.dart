import 'package:chat_app_encyrpt/constant/constant.dart';
import 'package:flutter/material.dart';

class FillOutlineButton extends StatelessWidget {
  const FillOutlineButton({
    Key? key,
    this.isFilled = true,
    required this.press,
    required this.text,
  }) : super(key: key);

  final bool isFilled;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: kSecondaryColor, width: 2),
      ),
      elevation: isFilled ? 2 : 0,
      onPressed: press,
      minWidth: 200,
      padding: const EdgeInsets.all(kDefaultPadding * 0.75),
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? kContentColorLightTheme : Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}