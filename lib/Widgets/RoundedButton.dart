import 'package:flutter/material.dart';
import 'package:reservationapp/constants.dart';

class Roundedbutton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final String buttonText;

  const Roundedbutton(
      {Key key, this.text, this.press, this.color, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          color: kPrimaryColor,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          onPressed: press,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
