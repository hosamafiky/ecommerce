import 'package:ecommerce/provider/modelHud.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/user/login_screen.dart';
import 'package:ecommerce/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  static String id = "SignupScreen";
  // ignore: unused_field
  String _name, _email, _password;
  final _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(children: <Widget>[
          LogoWidget(),
          SizedBox(height: height * 0.08),
          CustomTextField(
            hint: 'Enter your full name!',
            icon: Icons.perm_identity,
            keyboard: TextInputType.text,
            onClick: (value) {
              _name = value;
            },
          ),
          SizedBox(height: height * 0.02),
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
          SizedBox(height: height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 135.0),
            child: Builder(
              builder: (context) => FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.black,
                onPressed: () async {
                  final modelHud =
                      Provider.of<ModelHud>(context, listen: false);
                  modelHud.changeIsLoading(true);
                  if (_globalKey.currentState.validate()) {
                    _globalKey.currentState.save();
                    try {
                      await _auth.signUp(_email, _password);
                      modelHud.changeIsLoading(false);
                      Navigator.pushNamed(context, HomePage.id);
                    } on PlatformException catch (e) {
                      modelHud.changeIsLoading(false);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.message),
                        ),
                      );
                    }
                  }
                  modelHud.changeIsLoading(false);
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Already have an account?',
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
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Text('Login',
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
