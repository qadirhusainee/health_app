import 'package:flutter/material.dart';

import 'package:health_app/screens/Login.dart';
import 'package:health_app/utils/sharedPreferences.dart';
import 'package:health_app/utils/Config.dart';

final imagesList = [
  "assets/onBoardingImage/step_1.png",
  "assets/onBoardingImage/step_2.png",
  "assets/onBoardingImage/step_3.png",
];
final detailsList = [
  "Health Assessment",
  "Goals & Habits",
  "Better health",
];

class OnBoarding extends StatefulWidget {
  static const routeName = '/onBoarding';
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentPage = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 1,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return itemBuilder(index);
                    },
                    controller: _pageController,
                    pageSnapping: true,
                    onPageChanged: _onPageChanged,
                    itemCount: 3,
                    physics: ClampingScrollPhysics(),
                  ),
                ),
                _detailsBuilder(currentPage),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _detailsBuilder(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
        }

        return Expanded(
          child: Transform.translate(
            offset: Offset(0, 100 + (-value * 100)),
            child: Opacity(
              opacity: value,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      detailsList[index],
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      color: Colors.white10,
                      width: double.infinity,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            imagesList.length,
                            (i) => Container(
                                  height: 10,
                                  width: 10,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: i == currentPage
                                          ? Color.fromRGBO(119, 102, 254, 1)
                                          : Color.fromRGBO(215, 218, 240, 1),
                                      shape: BoxShape.circle),
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FlatButton(
                      color: Color.fromRGBO(119, 102, 254, 1),
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        if (index < 2) {
                          _pageController.animateToPage(
                            ++index,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          setBoolPreference(
                              Config.renderingFirstTimeKey, false);
                          Navigator.pushReplacementNamed(
                              context, Login.routeName);
                        }
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      shape: CircleBorder(),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemBuilder(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
          return Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                height: Curves.easeIn.transform(value) *
                    MediaQuery.of(context).size.height *
                    0.7,
                child: child,
              ));
        } else {
          return Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                height:
                    Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                        MediaQuery.of(context).size.height *
                        0.7,
                child: child,
              ));
        }
      },
      child: Container(
        child: Image.asset(
          imagesList[index],
          width: double.maxFinite,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
