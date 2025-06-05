import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? file = await _picker.pickImage(
    source: source,
    imageQuality: 100,
  );
  if (file != null) {
    return await file.readAsBytes();
  }
  print('No image selected');
  return null;
}
showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      duration: const Duration(seconds: 2),
    ),
  );
}