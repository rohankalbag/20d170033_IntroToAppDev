import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  //collection reference
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference todoCollection = FirebaseFirestore.instance.collection("users");

  Future updateUserData(String name, String email) async{
    return await todoCollection.doc(uid).set({
      'name': name,
      'email' : email,
    });
  }
}