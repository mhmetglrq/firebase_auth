import 'package:flutter/material.dart';

import '../../../common/colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "The Bear is here!",
              style: TextStyle(
                fontSize: 20,
                color: titleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
