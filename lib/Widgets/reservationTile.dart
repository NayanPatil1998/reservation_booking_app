import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservationapp/models/ReservationModel.dart';
import 'package:reservationapp/screens/taskDetail.dart';

class ReservationTile extends StatelessWidget {
  final ReservationModel reservation;

  ReservationTile({this.reservation});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ReservationDetailPage(documentID: reservation.keyId,)));
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Icon(FontAwesomeIcons.calendarCheck),
            ),
            title: Text(reservation.name),
            subtitle: Text(reservation.emailId),
          ),
        ),
      ),
    );
  }
}
