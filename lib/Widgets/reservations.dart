import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservationapp/Widgets/spinner.dart';
import 'package:reservationapp/models/ReservationModel.dart';
import 'package:reservationapp/Widgets/reservationTile.dart';

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  @override
  Widget build(BuildContext context) {
    final reservations = Provider.of<List<ReservationModel>>(context);
//    print(reservations.length);
//    reservations.forEach((element) {
//      print(element.name);
//      print(element.mNumber);
//      print(element.emailId);
//      print(element.dob);
//    });

    if(reservations == null)
      return Container(
        child: SpinnerWidget(),
      );
    else
    return ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
            return ReservationTile(reservation: reservations[index]);
        });
  }
}
