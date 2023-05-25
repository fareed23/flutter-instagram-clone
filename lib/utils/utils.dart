import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/colors.dart';

pickImage(ImageSource source) async {
  final _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
    // File is from dart:io which is not accessible on flutter web
    // return File(_file.path); // We are not using this File method cause its not there on the flutter web version
  }
  print('No image selected');
}

showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

// snackBarMessage(String message) {
//   SnackBar(
//     content: Text(message),
//     behavior: SnackBarBehavior.floating,
//     clipBehavior: Clip.hardEdge,
//     backgroundColor: Colors.red,
//   );
// }

void toastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red[900],
    textColor: Colors.white,
    fontSize: 16,
  );
}
