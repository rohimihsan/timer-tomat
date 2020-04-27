import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _timer = [
    "25:00",
    "5:00",
    "15:00"
  ];

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
      backgroundColor: Color(0xffF4F0BB),
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            _buildPageView(),
            _buildCircleIndicator(),
          ],
        ),
      ],
    );
  }

  _buildPageView() {
    return Container(
      // color: Colors.black87,
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
          itemCount: 3,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return Center(
                child: Text(
                _timer[index],
                style: TextStyle(color: Color(0xff226F54), fontSize: 50, height: 5),
                textAlign: TextAlign.center,
              ),
            );
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
    );
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 150.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: 3,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }
}