import 'package:flutter/material.dart';
import 'package:fudo/data/models/post_model.dart';
import 'package:fudo/presentation/views/auth/login_screen.dart';
import 'package:fudo/presentation/views/posts/post_list_screen.dart';
import 'package:fudo/presentation/views/posts/post_create_screen.dart';
import 'package:fudo/presentation/views/posts/post_detail_screen.dart';

class RoutePath {
  RoutePath._();
  
  static const String home = '/home';
  static const String login = '/login';
  static const String postCreate = '/post/create';
  static const String postDetail = '/post/detail';
}

Map<String, WidgetBuilder> routes = {
  RoutePath.home: (context) => const PostListScreen(),
  RoutePath.login: (context) => const LoginScreen(),
  RoutePath.postCreate: (context) => const PostCreateScreen(),
  RoutePath.postDetail: (context) {
    final settings = ModalRoute.of(context)!.settings;
    return PostDetailScreen(post: settings.arguments as PostModel);
  },
};