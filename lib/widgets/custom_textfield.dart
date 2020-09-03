import 'package:flutter/material.dart';
import 'package:ecommerce/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {@required this.onClick,
      @required this.hint,
      @required this.icon,
      this.keyboard});
  final String hint;
  final IconData icon;
  final TextInputType keyboard;
  final Function onClick;

  // ignore: missing_return
  String _errorMessage(String str) {
    switch (hint) {
      case 'Enter your full name!':
        return 'Name is required';
      case 'Enter your email address!':
        return 'Email Address is required';
      case 'Enter your password!':
        return 'Password is required';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(hint);
          }
        },
        onSaved: onClick,
        obscureText: hint == 'Enter your password!' ? true : false,
        cursorColor: kMainColor,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: kMainColor),
          filled: true,
          fillColor: kSecondaryColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
