import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reservationapp/Widgets/RoundedButton.dart';
import 'package:reservationapp/Widgets/RoundedTextField.dart';
import 'package:reservationapp/Widgets/spinner.dart';
import 'package:reservationapp/constants.dart';
import 'package:reservationapp/services/auth.dart';

class SignUpPage extends StatefulWidget {

  final Function toggleView;

  const SignUpPage({this.toggleView});



  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String name = '';
  String email = '';
  String password ='';
  bool loading  = false;
  AuthService _auth = AuthService();
void _validateInputs() async {
      if (_formKey.currentState.validate()) {
        setState(() {
          loading = true;
        });
//    If all data are correct then save data to out variables
        _formKey.currentState.save();
        setState(() {
          _autoValidate = true;
        });
        dynamic result = await _auth.signUpwithEmail(email, password,name);
        if(result == null)
        setState(() {
          loading = false;
        });
        print(result.uid);
      }
    }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    

    return loading ? SpinnerWidget() : Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: kLightBlackColor,
                            blurRadius: 40,
                            spreadRadius: 15,
                            offset: new Offset(20, 10),
                          )
                        ],
                      ),
                      child: RadiantGradientMask(
                        child: Icon(
                          FontAwesomeIcons.calendarAlt,
                          size: 50,
                          color: Color(0xff9150E0),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * .07,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up',
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
                        hintText: "Name",
                        validator: (input) =>
                            input.isEmpty ? "*Required" : null,
                        onSaved: (value) => {setState(() => name = value)},
                      ),
                      RoundedTextField(
                        textType: TextInputType.emailAddress,
                        validator: (input) =>
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(input)
                                ? null
                                : "*Enter a valid email",
                        hintText: "Email",
                        onSaved: (value) => {setState(() => email = value)},
                      ),
                      RoundedTextField(
                        textType: TextInputType.text,
                        validator: (input) =>
                            input.isEmpty ? "*Required" : null,
                        secureType: true,
                        hintText: "Password",
                        onSaved: (value) => {setState(() => password = value)},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Roundedbutton(
                        buttonText: "Sign up",
                        color: kPrimaryColor,
                        press: () {
                          _validateInputs();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Have a account ? ',
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 18,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.white, Color(0xff9150E0)],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
