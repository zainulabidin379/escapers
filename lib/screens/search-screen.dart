import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../shared/constants.dart';
import 'screens.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: <Widget>[

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifications()),
              );
            },
            child: Container(
              width: 50,
              child: Icon(
                FontAwesomeIcons.solidBell,
                color: kBlack,
                size: 30,
              ),
            ),
          ),

        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16,),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              fontSize: 22,
              color: kGrey,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                  color: kPrimaryColor, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: kPrimaryColor,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: kPrimaryColor,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 24.0, left: 8.0),
              child: Icon(
                Icons.search,
                color: kGrey,
                size: 26,
              ),
            ),
          ),
          style: kBodyText.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
