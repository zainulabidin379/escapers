import 'package:escapers_app/models/account_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../shared/shared.dart';
import '../screens/screens.dart';
import '../services/services.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  String dpUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Profile",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FutureBuilder<dynamic>(
                        future: FetchData().dpUrl(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data),
                              backgroundColor: Colors.white,
                            );
                          } else {
                            return CircleAvatar(
                              backgroundImage: dpUrl != null
                                  ? NetworkImage(dpUrl)
                                  : AssetImage('assets/icons/user.png'),
                              backgroundColor: Colors.white,
                            );
                          }
                        }),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ProfileMenu(
                text: "My Account",
                icon: FontAwesomeIcons.userAlt,
                press: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyAccount()),
                  )
                },
              ),
              ProfileMenu(
                text: "Become Host",
                icon: FontAwesomeIcons.guilded,
                press: () => {Get.to(() => HostScreen())},
              ),
              ProfileMenu(
                text: "Settings",
                icon: Icons.settings,
                press: () => {
                  Get.snackbar(
                    'Message',
                    'This function is not yet implemented',
                    duration: Duration(seconds: 3),
                    backgroundColor: kPrimaryColor,
                    colorText: kWhite,
                    borderRadius: 10,
                  ),
                },
              ),
              ProfileMenu(
                text: "FAQs",
                icon: Icons.question_answer,
                press: () => {
                  Get.snackbar(
                    'Message',
                    'This function is not yet implemented',
                    duration: Duration(seconds: 3),
                    backgroundColor: kPrimaryColor,
                    colorText: kWhite,
                    borderRadius: 10,
                  ),
                },
              ),
              ProfileMenu(
                text: "Help Center",
                icon: FontAwesomeIcons.solidQuestionCircle,
                press: () => {
                  Get.snackbar(
                    'Message',
                    'This function is not yet implemented',
                    duration: Duration(seconds: 3),
                    backgroundColor: kPrimaryColor,
                    colorText: kWhite,
                    borderRadius: 10,
                  ),
                },
              ),
              ProfileMenu(
                text: "Sign Out",
                icon: FontAwesomeIcons.signOutAlt,
                press: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Wrapper()),
                  );
                  Get.snackbar(
                    'Message',
                    'Signed Out Successfully',
                    duration: Duration(seconds: 3),
                    backgroundColor: kPrimaryColor,
                    colorText: kWhite,
                    borderRadius: 10,
                  );
                },
              ),
            ],
          ),
        ));
  }

// fetchData() async {
//   var currentUser = _auth.getCurrentUser();
//   DocumentSnapshot variable = await FirebaseFirestore.instance
//       .collection('users')
//       .doc(currentUser)
//       .get();
//   dpUrl = variable['dpUrl'];
// }
}
