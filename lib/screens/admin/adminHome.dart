import 'package:ecommerce/screens/admin/addProduct.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add a product'),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('Edit a product'),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('View Orders'),
          ),
        ],
      ),
    );
  }
}
