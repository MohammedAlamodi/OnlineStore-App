import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_app/constants.dart';
import 'package:market_app/models/Category.dart';
import 'package:market_app/models/product.dart';

class Store {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final databaseReference = FirebaseFirestore.instance;

  addUserInfo(uid, String userName, String userGovernorate) {
    var databaseRef = _fireStore.collection("Users").doc(uid);
    databaseRef.set({
      kUserName: userName,
      kUserGovernorate: userGovernorate,
    });
  }

  Future<List<String>> loadUserInfo(uid) async {
    var data = await _fireStore.collection("Users").doc(uid).get();
    List<String> userInfo = [];
    userInfo.add(data[kUserName]);
    userInfo.add(data[kUserGovernorate]);
    return userInfo;
  }

  addProduct(ProductData product) {
    _fireStore.collection(kProductCollection).add({
      kProductName: product.proName,
      kProductPrice: product.proPrice,
      kProductDescription: product.proDescription,
      kProductCategory: product.proCategory,
      kProductLocation: product.proLocation,
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _fireStore.collection(kProductCollection).snapshots();
  }

  Future<List<String>> loadCategory() async {
    var snapshot = await _fireStore.collection(kCategoryCollection).get();
    List<String> categories = [];
    for (var doc in snapshot.docs) {
      var data = doc.data();
      categories.add(data["name"]);
    }
    return categories;
  }

  deleteProduct(docID) {
    _fireStore.collection(kProductCollection).doc(docID).delete();
  }

  editProduct(docID, data) {
    _fireStore.collection(kProductCollection).doc().update(data);
  }

  storeOrders(data, List<ProductData> products) {
    var databaseRef = _fireStore.collection(kOrdersCollection).doc();
    databaseRef.set(data);
    for (var product in products) {
      databaseRef.collection(kOrderDetails).doc().set({
        kProductName: product.proName,
        kProductCategory: product.proCategory,
        kProductPrice: product.proPrice,
        kProductQuantity: product.proQuantity,
        kProductLocation: product.proLocation,
      });
    }
  }

  Stream<QuerySnapshot> loadOrders() {
    return _fireStore.collection(kOrdersCollection).snapshots();
  }

  Stream<QuerySnapshot> loadOrdersDetails(documentId) {
    return _fireStore.collection(kOrdersCollection).doc(documentId).collection(kOrderDetails).snapshots();
  }
}
