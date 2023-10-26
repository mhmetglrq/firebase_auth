import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/colors.dart';
import '../../../common/sizes.dart';
import '../../../models/user_model.dart';
import '../controller/profile_controller.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: scaffoldPadding,
          child: FutureBuilder<UserModel>(
              future: ref.read(profileControllerProvider).getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userModel = snapshot.data!;
                  return Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: vertical10,
                          child: CircleAvatar(
                            backgroundColor: profilePhotoCircleColor,
                            radius: 50,
                            child: CircleAvatar(
                              backgroundColor: profilePhotoCircleColor,
                              radius: 48,
                              backgroundImage: CachedNetworkImageProvider(
                                userModel.profilePhoto!,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: vertical10,
                          child: Text(
                            "@${userModel.username}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: titleColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: vertical10,
                          child: Text(
                            "${userModel.name} ${userModel.surname}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: titleColor,
                            ),
                          ),
                        ),
                        MaterialButton(
                          color: profilePhotoCircleColor,
                          onPressed: () {},
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(
                              color: borderColor,
                            ),
                          ),
                          minWidth: 200,
                          child: const Padding(
                            padding: vertical10,
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              }),
        ),
      ),
    );
  }
}
