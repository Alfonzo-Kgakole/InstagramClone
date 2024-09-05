import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? _file = await imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  {
    print("file image not selected");
  }
}

showSnakBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}
