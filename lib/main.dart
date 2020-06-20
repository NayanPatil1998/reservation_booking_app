import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservationapp/models/user.dart';
import 'package:reservationapp/services/auth.dart';
import 'package:reservationapp/screens/Wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
