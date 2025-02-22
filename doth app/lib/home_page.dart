import 'package:doth/data/user.dart';
import 'package:doth/profile/profile_page.dart';
import 'package:doth/temp/first_screen.dart';
import 'package:doth/temp/second_screen.dart';
import 'package:doth/temp/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

import 'animated_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;

  //Color backgroundColor = const Color(0xff050B18);
  Color backgroundColor = const Color(0xffffffff);

  List<String> titles = ['First', 'Second', 'Third', 'Profile'];
  List<String> bodyImages = [
    'assets/images/body_home.png',
    'assets/images/bo'
        'dy_search.png',
    'assets/images/body_rank.png',
    'assets/images/body_video.png'
  ];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    bool canVibrate = await Vibrate.canVibrate;
    User.shared().canVibrate = canVibrate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: _tabPages[_currentIndex],
        bottomNavigationBar: _buildBottomBar());
  }

  final _tabPages = <Widget>[
    const FirstScreen(),
    const SecondScreen(),
    const ProfileScreen()
  ];

  Widget _buildBottomBar() {
    return AnimatedBottomBar(
      containerHeight: 56,
      backgroundColor: backgroundColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 12,
      curve: Curves.easeInOut,
      onItemSelected: (index) {
        if (User.shared().canVibrate && _currentIndex != index) {
          Vibrate.feedback(FeedbackType.success);
        }
        setState(() => _currentIndex = index);
      },
      items: <MyBottomNavigationBarItem>[
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.money_rounded),
          title: Text(titles[0]),
          activeColor: const Color(0xff006270),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.map),
          title: Text(titles[1]),
          activeColor: const Color(0xff009394),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.apps),
          title: Text(titles[2]),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.person),
          title: Text(titles[3]),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
