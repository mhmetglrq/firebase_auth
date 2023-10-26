import 'package:flutter/material.dart';
import 'package:flutter_auth_app/common/paths.dart';
import 'package:flutter_auth_app/common/sizes.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/colors.dart';
import '../../widgets/appbar_with_title.dart';
import '../../widgets/content_listview.dart';
import '../../widgets/subtitle_widget.dart';

class Browse extends StatelessWidget {
  const Browse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarWithTitle(title: "Browse"),
              const SubTitleWidget(
                title: "Most Viewed Articles",
              ),
              const Expanded(
                flex: 3,
                child: ContentListView(),
              ),
              const SubTitleWidget(
                title: "Most Viewed Codes",
              ),
              Expanded(
                flex: 5,
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: vertical5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      bookmarkImage,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: horizontal10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "For My Project Need ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    "Mehmet Güler",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: greyColor,
                                    ),
                                  ),
                                  Text(
                                    "125,908 views  •  2 days ago",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: horizontal10,
                              child: CircleAvatar(
                                backgroundColor: activeColor,
                                child: SvgPicture.asset(
                                  bookmarkSvg,
                                  colorFilter: const ColorFilter.mode(
                                    whiteColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
