import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final AuthService _auth = AuthService();
  bool isEditing = false;
  bool imageUpdated = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();

  String name;
  String email;
  String location;
  String dpUrl;

  File _dpImage;
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    print(dpUrl);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kBlack,
            ),
          ),
          title: Text(
            "My Account",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    overflow: Overflow.visible,
                    children: [
                      CircleAvatar(
                        backgroundImage: dpUrl != null
                            ? NetworkImage(dpUrl)
                            : AssetImage('assets/icons/user.png'),
                        backgroundColor: Colors.white,
                      ),
                      isEditing
                          ? Positioned(
                              right: -8,
                              bottom: 0,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    pickImage();
                                  },
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        FontAwesomeIcons.pen,
                                        color: kPrimaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: TextField(
                    controller: nameController,
                    enabled: isEditing,
                    cursorColor: kPrimaryColor,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: kPrimaryColor, fontSize: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: name,
                      hintStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: TextField(
                    controller: emailController,
                    enabled: isEditing,
                    cursorColor: kPrimaryColor,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      labelText: 'E-mail',
                      labelStyle: TextStyle(color: kPrimaryColor, fontSize: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: email,
                      hintStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: TextField(
                    controller: locationController,
                    enabled: isEditing,
                    cursorColor: kPrimaryColor,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      labelText: 'Location',
                      labelStyle: TextStyle(color: kPrimaryColor, fontSize: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: location,
                      hintStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                isEditing ? saveButtonRow() : editInfoButton()
              ],
            ),
          ),
        ));
  }

  Padding editInfoButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: InkWell(
        onTap: () {
          setState(() {
            isEditing = true;
          });
          print(dpUrl);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: Colors.green,
          ),
          child: Center(
            child: Text(
              'Edit Info',
              style: kBodyText.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Row saveButtonRow() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 5.0, top: 20.0),
          child: InkWell(
            onTap: () {
              setState(() {
                isEditing = false;
              });
            },
            child: Container(
                alignment: Alignment.center,
                height: 50.0,
                decoration: BoxDecoration(
                    color: kGrey, borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
                child: Text(
                  'Cancel',
                  style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                )),
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 20.0, top: 20.0),
          child: InkWell(
            onTap: () async {
              setState(() {
                isEditing = false;
                if (nameController.text == '') {
                  nameController.text = name;
                }
                if (emailController.text == '') {
                  emailController.text = email;
                }
                if (locationController.text == '') {
                  locationController.text = location;
                }
              });
              await DatabaseService(uid: _auth.getCurrentUser()).updateUserData(
                nameController.text,
                emailController.text,
                locationController.text,
              );

              if (imageUpdated == true){
                uploadImageToFirebase();
              }
              Get.snackbar(
                'Message',
                'Account information updated Successfully',
                duration: Duration(seconds: 3),
                backgroundColor: kPrimaryColor,
                colorText: kWhite,
                borderRadius: 10,
              );
            },
            child: Container(
                alignment: Alignment.center,
                height: 50.0,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),),
                child: Text(
                  'Save',
                  style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                )),
          ),
        )),
      ],
    );
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _dpImage = File(pickedFile.path);
      uploadImageToFirebase();
      imageUpdated = true;
    });
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(_auth.getCurrentUser());
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_dpImage);
    uploadTask.whenComplete(() async {
      String url = await firebaseStorageRef.getDownloadURL();
      var currentUser = _auth.getCurrentUser();
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser)
          .update({"dpUrl": url}).then((_) {
        print("success!");
        fetchData();
      });
    }).catchError((onError) {
      print(onError);
    });
    //return url;
  }

  fetchData() async {
    var currentUser = _auth.getCurrentUser();
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .get();
    setState(() {
      name = variable['name'];
      email = variable['email'];
      location = variable['location'];
      dpUrl = variable['dpUrl'];
    });
  }
}
