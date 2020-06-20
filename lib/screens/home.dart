import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:reservationapp/screens/addTask.dart';
import 'package:reservationapp/services/auth.dart';
import 'package:reservationapp/services/database.dart';
import 'package:reservationapp/Widgets/reservations.dart';
import 'package:reservationapp/models/ReservationModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  FirebaseUser mCurrentUser;
  String uid;
  @override
  void initState() {
    super.initState();
    //     FirebaseUser user = .currentUser();
    // setState(() async{
    //   currentUser = await getCurrentUser();
    // });
    _getCurrentUser();
  }
  _getCurrentUser() async {
    mCurrentUser = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = mCurrentUser.uid.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ReservationModel>>.value(
      value: DataBaseService().tasks,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Reservations'),
        ),
        body: Reservation(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTask(),
              ),
            );
          },
        ),
      ),
    );
  }
}
