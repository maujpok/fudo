import 'package:flutter/material.dart';
import 'package:fudo/app/ui_style.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const Text('Posts'),
      ),
      body: Container(),
    );
  }
}
