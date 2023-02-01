import 'package:flutter/material.dart';
import '../shared/shared.dart';

// ignore: must_be_immutable
class ProfileMenu extends StatelessWidget {
  final String text;
  IconData icon;
  final VoidCallback press;

  ProfileMenu({Key key, this.text, this.icon, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: FlatButton(
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
              color: kPrimaryColor, width: 1.5, style: BorderStyle.solid),
        ),
        color: Colors.white,
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: kPrimaryColor,
              size: 20,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(text,
              style: kBodyText.copyWith(color: kBlack, fontSize: 17)),
            ),
            Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
          ],
        ),
      ),
    );
  }
}
