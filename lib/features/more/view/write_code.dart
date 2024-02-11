import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth_app/common/sizes.dart';
import 'package:flutter_auth_app/common/utils.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../common/paths.dart';
import '../../../common/repository/common_firebase_storage.dart';
import '../../../models/code_model.dart';
import '../../../models/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/dart.dart';

import '../controller/more_controller.dart';

class WriteCode extends ConsumerStatefulWidget {
  final UserModel currentUser;
  const WriteCode({super.key, required this.currentUser});

  @override
  ConsumerState<WriteCode> createState() => _WriteArticleState();
}

class _WriteArticleState extends ConsumerState<WriteCode> {
  XFile? image;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final CodeController _codeController = CodeController(
    text: "print('Hello, World!')",
    language: dart,
  );

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void pickImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: whiteColor,
              ),
            ),
            title: const Text(
              "Your Code",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final user = widget.currentUser;
                    ref
                        .read(commonFSRepositoryProvider)
                        .storeFileToFirebase(
                          "codes/${user.uid}/${DateTime.now().millisecondsSinceEpoch}",
                          File(image!.path),
                        )
                        .then((value) {
                      String uid = const Uuid().v4();
                      CodeModel codeModel = CodeModel(
                        uid: uid,
                        title: _titleController.text,
                        description: _contentController.text,
                        code: _codeController.text,
                        coverImg: value,
                        author: "${user.name} ${user.surname}",
                        autherUid: user.uid!,
                        authorImg: user.profilePhoto!,
                        createdAt: DateTime.now(),
                        claps: 0,
                        views: 0,
                      );
                      ref
                          .read(moreControllerProvider)
                          .writeCode(codeModel)
                          .then((value) => Navigator.pop(context));
                    });
                  }
                },
                icon: const Icon(
                  Icons.done,
                  color: whiteColor,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: scaffoldPadding,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            style: const TextStyle(
                              fontSize: 17,
                              color: whiteColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please fill the title";
                              }
                              return null;
                            },
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: "Your Title Here!",
                              hintStyle: TextStyle(
                                fontSize: 17,
                                color: greyColor,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          Padding(
                            padding: vertical10,
                            child: GestureDetector(
                              onTap: () {
                                pickImage();
                              },
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: activeColor,
                                    borderRadius: BorderRadius.circular(20),
                                    image: image != null
                                        ? DecorationImage(
                                            image: FileImage(File(image!.path)),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      image == null
                                          ? SvgPicture.asset(
                                              addImageSvg,
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please fill the content";
                              }
                              return null;
                            },
                            controller: _contentController,
                            style: const TextStyle(
                              fontSize: 17,
                              color: whiteColor,
                            ),
                            maxLines: 5,
                            minLines: 1,
                            decoration: const InputDecoration(
                              hintText: "Your description here!",
                              hintStyle: TextStyle(
                                fontSize: 17,
                                color: greyColor,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          CodeTheme(
                            data: CodeThemeData(
                              styles: myTheme,
                            ),
                            child: SingleChildScrollView(
                              child: CodeField(
                                controller: _codeController,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
