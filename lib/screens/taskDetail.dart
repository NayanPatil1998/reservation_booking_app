import 'package:flutter/material.dart';
import 'package:reservationapp/Widgets/spinner.dart';
import 'package:reservationapp/models/ReservationModel.dart';
import 'package:reservationapp/screens/editTask.dart';
import 'package:reservationapp/services/database.dart';

class ReservationDetailPage extends StatefulWidget {
  final String documentID;

  ReservationDetailPage({@required this.documentID});

  @override
  _ReservationDetailPageState createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.documentID);
    return StreamBuilder<ReservationModel>(
        stream: DataBaseService().getDocumentById(widget.documentID),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Reservation Detail'),
              ),
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        'Name - ${snapshot.data.name}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Email Id - ${snapshot.data.emailId}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Date of birth - ${snapshot.data.dob}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Mobile Number - ${snapshot.data.mNumber}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTask(
                                  documentID: widget.documentID,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              "Update",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await DataBaseService().removeData(widget.documentID);
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              "Delete",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            alignment: Alignment.center,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
            );
          } else {
            return Scaffold(
              body: SpinnerWidget(),
            );
          }
        });
  }
}
