import 'package:flutter/material.dart';
import 'package:fudo/app/extensions.dart';
import 'package:fudo/app/routes.dart';
import 'package:fudo/app/ui_style.dart';
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
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMin,
      ),
      child: ListTile(
        onTap: () => context.pushNamed(
          RoutePath.postDetail,
          arguments: post,
        ),
        title: Text(
          post?.title ?? '',
          maxLines: 2,
          overflow: TextOverflow.fade,
        ),
        subtitle: Text(
          post?.body ?? '',
          maxLines: 2,
          overflow: TextOverflow.fade,
        ),
        leading: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('User Id'),
            Text(post?.userId.toString() ?? ''),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
