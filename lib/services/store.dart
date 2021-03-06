import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';

class Store {
  final Firestore _firestore = Firestore.instance;
  addProduct(Product product) {
    _firestore.collection(kProductCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductCategory: product.pCategory,
      kProductLocation: product.pLocation,
    });
  }
}
