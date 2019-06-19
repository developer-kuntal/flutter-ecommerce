// import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  Firestore _firestore = Firestore.instance;
  String collection = "users";

  void createUser(Map data) {
    // String id = value["userId"];
    // _database.reference().child("$ref/$id").set(
    //   value
    // ).catchError((e) => {
    //   print(e.toString())
    // });
    _firestore.collection(collection).document(data["userId"]).setData(data);
  }
}