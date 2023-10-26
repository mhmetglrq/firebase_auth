import 'package:flutter/material.dart';
import 'package:flutter_auth_app/common/paths.dart';
import 'package:flutter_auth_app/features/discover/views/discover.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bookmark/views/bookmark.dart';
import '../../browse/views/browse.dart';
import '../../more/view/more.dart';

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
    const Discover(),
    const Browse(),
    const Bookmark(),
    const More(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              discoverSvg,
            ),
            activeIcon: SvgPicture.asset(
              discoverActiveSvg,
            ),
            label: "Discover",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              browseSvg,
            ),
            activeIcon: SvgPicture.asset(
              browseActiveSvg,
            ),
            label: "Browse",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              bookmarkSvg,
            ),
            activeIcon: SvgPicture.asset(
              bookmarkActiveSvg,
            ),
            label: "Bookmark",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              profileSvg,
            ),
            activeIcon: SvgPicture.asset(
              profileActiveSvg,
            ),
            label: "More",
          ),
        ],
      ),
    );
  }
}
