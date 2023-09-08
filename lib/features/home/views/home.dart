import 'package:flutter/material.dart';
import 'package:flutter_auth_app/common/paths.dart';
import 'package:flutter_auth_app/features/dashboard/views/dashboard.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/colors.dart';
import '../../profile/views/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> list = [
    const Dashboard(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          color: titleColor,
        ),
        unselectedLabelStyle: const TextStyle(
          color: titleColor,
        ),
        currentIndex: _currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              homeDeactiveSvg,
            ),
            activeIcon: SvgPicture.asset(
              homeActiveSvg,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              userDeactiveSvg,
            ),
            activeIcon: SvgPicture.asset(
              userActiveSvg,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
