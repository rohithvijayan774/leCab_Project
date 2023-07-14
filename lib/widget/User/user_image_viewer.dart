import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String? image;
  const ImageViewer({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image!),
          ),
        ),
      )),
    );
  }
}
