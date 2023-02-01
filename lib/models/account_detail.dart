import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escapers_app/services/services.dart';
import 'package:flutter/material.dart';


class FetchData {
  final AuthService _auth = AuthService();

  dpUrl() async{
    var currentUser = _auth.getCurrentUser();
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection('users').doc(currentUser).get();
      return variable['dpUrl'];
  }
}
