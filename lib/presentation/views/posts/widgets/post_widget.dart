import 'package:flutter/material.dart';
import 'package:fudo/app/extensions.dart';
import 'package:fudo/app/routes.dart';
import 'package:fudo/data/models/_models.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
  });

  final PostModel? post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => context.pushNamed(
          RoutePath.postDetail,
          arguments: post,
        ),
        title: Text(post?.title ?? ''),
        subtitle: Text(
          post?.body ?? '',
          maxLines: 2,
          overflow: TextOverflow.fade,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
