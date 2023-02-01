import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  Map data;

  // collection reference
  final CollectionReference escapersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addUserData(String name, String email, String location, String dpUrl) async {
    return await escapersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'location': location,
      'dpUrl': dpUrl,
    });
  }

  Future<void> updateUserData(String name, String email, String location) async {
    return await escapersCollection.doc(uid).update({
      'name': name,
      'email': email,
      'location': location,
    });
  }


}