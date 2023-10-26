import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../common/paths.dart';
import '../../common/sizes.dart';

class ContentListView extends StatelessWidget {
  const ContentListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: right5,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage(bookmarkImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: all15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Prepare for your first skateboard jump",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                            ),
                          ),
                          Text(
                            "Mehmet Güler",
                            style: TextStyle(
                              fontSize: 14,
                              color: whiteColor,
                            ),
                          ),
                          Text(
                            "125,908 views",
                            style: TextStyle(
                              fontSize: 13,
                              color: whiteColor,
                            ),
                          ),
                          Text(
                            "2 days ago ",
                            style: TextStyle(
                              fontSize: 13,
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: all10,
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: blueColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
