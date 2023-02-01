import '../models/models.dart';
import 'package:flutter/material.dart';
import 'screens.dart';
import '../shared/constants.dart';
import '../models/data.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnBoardingList> list = OnBoardingList.list;
  var _controller = PageController();
  var initialPage = 0;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        initialPage = _controller.page.round();
      });
    });

    return Scaffold(
        body: Stack(
      children: [
        _body(_controller),
        _indicator(),
      ],
    ));
  }

  _body(PageController controller) {
    return PageView.builder(
      controller: controller,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              child: _displayImage(list[index].id),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _displayTitle(list[index].title),
                _displayText(list[index].text),
              ],
            ),
          ],
        );
      },
    );
  }

  _indicator() {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          width: 80,
          height: 80,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                    value: (initialPage + 1) / (list.length + 1),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Wrapper()),
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: kWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _displayImage(int path) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.center,
        colors: [Colors.black, Colors.transparent],
      ).createShader(rect),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/onboarding-$path.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                ColorFilter.mode(Colors.black54, BlendMode.darken))),
      ),
    );
  }

  _displayTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Text(
        title,
        style: kBodyText.copyWith(fontSize: 40,fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }

  _displayText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: kBodyText.copyWith(fontSize: 20),
        textAlign: TextAlign.left,
      ),
    );
  }
}
