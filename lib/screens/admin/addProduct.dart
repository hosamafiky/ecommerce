import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/services/store.dart';

// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _imageLocation;
  final _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(height: 10.0),
            CustomTextField(
              hint: 'Product Price',
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(height: 10.0),
            CustomTextField(
              hint: 'Product Description',
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(height: 10.0),
            CustomTextField(
              hint: 'Product Category',
              onClick: (value) {
                _category = value;
              },
            ),
            SizedBox(height: 10.0),
            CustomTextField(
              hint: 'Product Location',
              onClick: (value) {
                _imageLocation = value;
              },
            ),
            SizedBox(height: 15.0),
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  _store.addProduct(
                    Product(
                        pName: _name,
                        pPrice: _price,
                        pDescription: _description,
                        pCategory: _category,
                        pLocation: _imageLocation),
                  );
                }
              },
              child: Text(
                'Add Product',
              ),
            )
          ],
        ),
      ),
    );
  }
}
