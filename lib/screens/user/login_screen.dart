import 'package:ecommerce/constants.dart';
import 'package:ecommerce/provider/adminMode.dart';
import 'package:ecommerce/provider/modelHud.dart';
import 'package:ecommerce/screens/admin/adminHome.dart';
import 'package:ecommerce/screens/user/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:ecommerce/screens/homepage.dart';
// ignore: unused_import
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static String id = "LoginScreen";
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password;
  bool isAdmin = false;
  final _auth = Auth();
  final adminPassword = 'admin123456';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(image: AssetImage('images/icons/buy.png')),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Buy it',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.1),
              CustomTextField(
                hint: 'Enter your email address!',
                icon: Icons.email,
                keyboard: TextInputType.emailAddress,
                onClick: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                hint: 'Enter your password!',
                icon: Icons.lock,
                keyboard: TextInputType.visiblePassword,
                onClick: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 135.0),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.black,
                    onPressed: () async {
                      _validate(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text('Signup',
                        style: TextStyle(
                          fontSize: 16.0,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(true);
                        },
                        child: Text(
                          'i\'m an admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? kMainColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(false);
                        },
                        child: Text(
                          'i\'m a user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? Colors.white
                                : kMainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.logIn(_email, _password);
            modelHud.changeIsLoading(false);
            Navigator.pushNamed(context, AdminHome.id);
          } on PlatformException catch (e) {
            modelHud.changeIsLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(e.message, textAlign: TextAlign.center)));
          }
        } else {
          modelHud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Something went wrong',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        try {
          await _auth.logIn(_email, _password);
          modelHud.changeIsLoading(false);
          Navigator.pushNamed(context, HomePage.id);
        } on PlatformException catch (e) {
          modelHud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(e.message, textAlign: TextAlign.center)));
        }
      }
    }
    modelHud.changeIsLoading(false);
  }
}
