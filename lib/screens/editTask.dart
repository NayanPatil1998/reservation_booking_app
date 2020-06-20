import 'package:flutter/material.dart';
import 'package:reservationapp/constants.dart';
import 'package:reservationapp/Widgets/RoundedButton.dart';
import 'package:reservationapp/Widgets/RoundedTextField.dart';
import 'package:reservationapp/Widgets/textFiledContainer.dart';
import 'package:reservationapp/models/ReservationModel.dart';
import 'package:reservationapp/services/database.dart';

class EditTask extends StatefulWidget {
  final String documentID;

  EditTask({@required this.documentID});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  String _name;
  String _email;
  String _mNumber;
  String _dob;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<ReservationModel>(
        stream: DataBaseService().getDocumentById(widget.documentID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Edit Reservation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: Column(
                            children: <Widget>[
                              RoundedTextField(
                                textType: TextInputType.text,
                                initialValue: snapshot.data.name,
                                hintText: "Name",
                                validator: (input) =>
                                    input.isEmpty ? "*Required" : null,
                                onSaved: (value) =>
                                    {setState(() => _name = value)},
                              ),
                              RoundedTextField(
                                textType: TextInputType.emailAddress,
                                validator: (input) =>
                                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(input)
                                        ? null
                                        : "*Enter a valid email",
                                hintText: "Email",
                                initialValue: snapshot.data.emailId,
                                onSaved: (value) =>
                                    {setState(() => _email = value)},
                              ),
                              RoundedTextField(
                                textType: TextInputType.phone,
                                initialValue: snapshot.data.mNumber,
                                validator: (input) =>
                                    input.isEmpty ? "*Required" : null,
                                secureType: false,
                                hintText: "Mobile Number",
                                onSaved: (value) =>
                                    {setState(() => _mNumber = value)},
                              ),
                              TextFieldContainer(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '$_dob',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 17),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final datePick = await showDatePicker(
                                              context: context,
                                              initialDate: new DateTime.now(),
                                              firstDate: new DateTime(1900),
                                              lastDate: new DateTime(2100));
                                          if (datePick != null) {
                                            setState(() {
                                              // put it here
                                              _dob =
                                                  "${datePick.month}/${datePick.day}/${datePick.year}"; // 08/14/2019
                                              print(_dob);
                                            });
                                          }
                                        },
                                        child: Icon(Icons.calendar_today),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Roundedbutton(
                                buttonText: "Submit",
                                color: kPrimaryColor,
                                press: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
//    If all data are correct then save data to out variables
                                    _formKey.currentState.save();
                                    setState(() {
                                      _autoValidate = true;
                                    });
                                    await DataBaseService().updateUserData(
                                        widget.documentID,
                                        _name ?? snapshot.data.name,
                                        _mNumber ?? snapshot.data.mNumber,
                                        _dob ?? snapshot.data.dob,
                                        _email ?? snapshot.data.emailId);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold();
          }
        });
  }
}
