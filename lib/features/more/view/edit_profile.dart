import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/common/repository/common_firebase_storage.dart';
import 'package:flutter_auth_app/common/sizes.dart';
import 'package:flutter_auth_app/features/more/controller/more_controller.dart';
import 'package:flutter_auth_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/colors.dart';
import '../../../common/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.currentUser});
  final UserModel currentUser;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _webController = TextEditingController();
  final TextEditingController _stackofController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _mediumController = TextEditingController();
  XFile? _image;

  void selectImage() async {
    _image = await pickImageFromGallery();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentUser.name;
    _surnameController.text = widget.currentUser.surname;
    _emailController.text = widget.currentUser.email;
    _usernameController.text = "@${widget.currentUser.username}";
    _descriptionController.text = widget.currentUser.description ?? "";
    _webController.text = widget.currentUser.web ?? "";
    _stackofController.text = widget.currentUser.stackof ?? "";
    _githubController.text = widget.currentUser.github ?? "";
    _linkedinController.text = widget.currentUser.linkedin ?? "";
    _mediumController.text = widget.currentUser.medium ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: whiteColor,
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: scaffoldPadding,
          child: Column(
            children: [
              Padding(
                padding: vertical10,
                child: GestureDetector(
                  onTap: () => selectImage(),
                  child: CircleAvatar(
                    backgroundColor: profilePhotoCircleColor,
                    radius: 70,
                    backgroundImage: _image != null
                        ? FileImage(File(_image!.path)) as ImageProvider
                        : CachedNetworkImageProvider(
                            widget.currentUser.profilePhoto!,
                          ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                    controller: _nameController,
                    title: 'Name',
                    value: widget.currentUser.name,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InputField(
                      controller: _surnameController,
                      title: 'Surname',
                      value: widget.currentUser.surname,
                    ),
                  ),
                ],
              ),
              InputField(
                controller: _webController,
                title: 'WEB Site',
                value: widget.currentUser.web,
              ),
              InputField(
                controller: _descriptionController,
                title: 'Name',
                value: widget.currentUser.description,
              ),
              InputField(
                controller: _usernameController,
                title: 'Username',
                value: widget.currentUser.username,
              ),
              InputField(
                controller: _emailController,
                title: 'E-Mail',
                value: widget.currentUser.email,
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                    controller: _githubController,
                    title: 'GitHub',
                    value: widget.currentUser.github,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: InputField(
                    controller: _linkedinController,
                    title: 'LinkedIn',
                    value: widget.currentUser.linkedin,
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      controller: _stackofController,
                      title: 'Stackoverflow',
                      value: widget.currentUser.stackof,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InputField(
                      controller: _mediumController,
                      title: 'Medium',
                      value: widget.currentUser.medium,
                    ),
                  )
                ],
              ),
              Consumer(
                builder: (context, ref, child) {
                  return Padding(
                    padding: vertical10,
                    child: MaterialButton(
                      onPressed: () async {
                        widget.currentUser.name = _nameController.text;
                        widget.currentUser.surname = _surnameController.text;
                        widget.currentUser.email = _emailController.text;
                        widget.currentUser.username = _usernameController.text;
                        widget.currentUser.description =
                            _descriptionController.text;
                        widget.currentUser.web = _webController.text;
                        widget.currentUser.stackof = _stackofController.text;
                        widget.currentUser.github = _githubController.text;
                        widget.currentUser.linkedin = _linkedinController.text;
                        widget.currentUser.medium = _mediumController.text;

                        if (_image != null) {
                          widget.currentUser.profilePhoto = await ref
                              .read(commonFSRepositoryProvider)
                              .storeFileToFirebase(
                                "profilePhotos/${widget.currentUser.uid}",
                                File(_image!.path),
                              );
                        } else {
                          widget.currentUser.profilePhoto =
                              widget.currentUser.profilePhoto;
                        }
                        UserModel userModel = widget.currentUser;
                        await ref
                            .read(moreControllerProvider)
                            .updateProfile(userModel)
                            .whenComplete(
                              () => Navigator.pop(context),
                            );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      color: activeColor,
                      minWidth: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required TextEditingController controller,
    required this.title,
    required this.value,
  }) : _controller = controller;
  final String title;
  final String? value;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _controller,
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          contentPadding: all5,
          fillColor: whiteColor,
          filled: true,
          hintText: title,
          hintStyle: const TextStyle(
            color: activeColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: borderColor,
            ),
          ),
        ),
      ),
    );
  }
}
