import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../models/data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem selectedItem;
  
  //Function to manage exit app button
  Future<bool> _onWillPop() async {
    return (await (showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: kPrimaryColor,
            title: new Text('Are you sure?', style: TextStyle(color: kWhite, fontWeight: FontWeight.bold)),
            content: new Text('Do you want to exit the App', style: TextStyle(color: kWhite, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No', style: TextStyle(color: kWhite, fontWeight: FontWeight.bold)),
              ),
              new TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Exit', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ))) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItem = navigationItems[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: selectedItem.page,
        bottomNavigationBar: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildNavigationItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildNavigationItems(){
    List<Widget> list = [];
    for (var navigationItem in navigationItems) {
      list.add(buildNavigationItem(navigationItem));
    }
    return list;
  }

  Widget buildNavigationItem(NavigationItem item){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width/5,
        decoration: selectedItem == item ? BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 4, color: Colors.green),
            ),
            gradient: LinearGradient(colors: [
              kPrimaryColor.withOpacity(0.3),
              kPrimaryColor.withOpacity(0.015),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
        )
            : BoxDecoration(),
        child: Center(
          child: Icon(
            item.iconData,
            color: selectedItem == item ? kPrimaryColor : Colors.grey[400],
            size: 28,
          ),
        ),
      ),
    );
  }

}