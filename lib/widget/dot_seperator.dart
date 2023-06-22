import 'package:flutter/material.dart';

class DotSeperator extends StatelessWidget {
  const DotSeperator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5                                      ),
      child: Container(
        height: 4,
        width: 4,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }
}
