import "dart:io";

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
//import 'package:cross_file/cross_file.dart'; //exposes the xfile

class ImageHolder extends StatefulWidget {
  final void Function(File item) imageFn;
  ImageHolder(this.imageFn);

  @override
  _ImageHolderState createState() => _ImageHolderState();
}

class _ImageHolderState extends State<ImageHolder> {
  File? _pickImage; // a file data that is exposed by dart.io

  void _pickedImage() async {
    final ImagePicker _picker = ImagePicker(); //initialing the imagePicker
    //Xfile is exposed by
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery); //to get image from g

    if (image != null) {
      //print("where");
      setState(() {
        _pickImage = File(image.path); //convert image xfile to file
      });
    }
    print("after setstate");
    widget.imageFn(_pickImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      CircleAvatar(
        radius: 70,
        backgroundColor: Colors.grey,
        backgroundImage: _pickImage != null ? FileImage(_pickImage!) : null,
      ),
      const SizedBox(width: 10),
      ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text("all Image"),
          onPressed: _pickedImage),
    ]);
  }
}
