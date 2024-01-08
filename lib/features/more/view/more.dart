// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/features/auth/views/sign_in.dart';
import 'package:flutter_auth_app/features/more/controller/more_controller.dart';
import 'package:flutter_auth_app/features/widgets/subtitle_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_auth_app/common/paths.dart';
import 'package:flutter_auth_app/common/sizes.dart';
import 'package:flutter_auth_app/models/user_model.dart';

import '../../../common/colors.dart';
import '../../../router/route_names.dart';

class More extends ConsumerWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
          future: ref.read(moreControllerProvider).getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userModel = snapshot.data!;
              return SafeArea(
                child: Padding(
                  padding: scaffoldPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "More",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                            ),
                          ),
                          Padding(
                            padding: vertical10,
                            child: CircleAvatar(
                              backgroundColor: profilePhotoCircleColor,
                              radius: 20,
                              backgroundImage: CachedNetworkImageProvider(
                                userModel.profilePhoto!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SubTitleWidget(
                        title: "Create Content",
                      ),
                      MenuItem(
                        title: "Write an article!",
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRouteNames.writeArticle,
                              arguments: {
                                "currentUser": userModel,
                              });
                        },
                        leadingAsset: articleSvg,
                      ),
                      MenuItem(
                        title: "Let's try the coding page!",
                        onTap: () {},
                        leadingAsset: codeSvg,
                      ),
                      MenuItem(
                        title: "Your articles",
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRouteNames.yourArticles,
                        ),
                        leadingAsset: articleSvg,
                      ),
                      MenuItem(
                        title: "Your code repos",
                        onTap: () {},
                        leadingAsset: codeSvg,
                      ),
                      const SubTitleWidget(
                        title: "Profile",
                      ),
                      MenuItem(
                        title: "Edit profile",
                        onTap: () => Navigator.pushNamed(
                            context, AppRouteNames.editProfile,
                            arguments: {
                              "currentUser": userModel,
                            }),
                        leadingAsset: editProfile,
                      ),
                      MenuItem(
                        title: "Sign out",
                        onTap: () {
                          ref
                              .read(moreControllerProvider)
                              .signOut()
                              .whenComplete(() => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SignIn(),
                                  ),
                                  (route) => false));
                        },
                        leadingAsset: signOutSvg,
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          }),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    this.onTap,
    required this.title,
    required this.leadingAsset,
  }) : super(key: key);
  final Function()? onTap;
  final String title;
  final String leadingAsset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: vertical5,
        child: Card(
          color: activeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 10,
          child: ListTile(
            leading: SvgPicture.asset(
              leadingAsset,
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: whiteColor,
                fontSize: 16,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
