import 'package:flutter/material.dart';

import '../constants.dart';

class HomeWrapContainer extends StatelessWidget {
  const HomeWrapContainer({
    Key key,
    this.leadIcon,
    this.titleText,
    this.taskNum,
  }) : super(key: key);

  final IconData leadIcon;
  final String titleText;
  final int taskNum;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {},
      child: Container(
        width: size.width * 0.5,
        height: size.height * 0.19,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              leadIcon,
              size: 30,
              color: Colors.green,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  titleText,
                  style: TextStyle(
                    color: kTitleColor,
                    fontFamily: 'LotoRegular',
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "$taskNum tasks",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: kDateColor,
                    fontFamily: 'LotoLight',
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
