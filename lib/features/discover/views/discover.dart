import 'package:flutter/material.dart';
import 'package:flutter_auth_app/common/colors.dart';
import 'package:flutter_auth_app/common/paths.dart';
import 'package:flutter_auth_app/features/widgets/content_listview.dart';

import '../../../common/sizes.dart';
import '../../widgets/appbar_with_title.dart';
import '../../widgets/subtitle_widget.dart';

class Discover extends StatelessWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarWithTitle(title: "Discover"),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: horizontal5,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(profileImage),
                          ),
                          Padding(
                            padding: top10,
                            child: Text(
                              "Budi",
                              style: TextStyle(
                                fontSize: 12,
                                color: greyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SubTitleWidget(
                title: "Most Viewed Articles",
              ),
              const Expanded(
                flex: 2,
                child: ContentListView(),
              ),
              const SubTitleWidget(
                title: "Most Viewed Codes",
              ),
              const Expanded(
                flex: 2,
                child: ContentListView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
