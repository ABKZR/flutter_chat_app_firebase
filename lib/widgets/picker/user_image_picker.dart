import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickfn;
  UserImagePicker({Key? key, required this.imagePickfn}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? path;
  final picker = ImagePicker();
  void _pickImage() async {
    final pickedImageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      path = File(pickedImageFile!.path);
    });
    widget.imagePickfn(path!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: path == null ? null : FileImage(path!)),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add image'),
        ),
      ],
    );
  }
}
