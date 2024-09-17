import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo/app/ui_style.dart';
import 'package:fudo/data/models/_models.dart';
import 'package:fudo/presentation/views/posts/bloc/posts_bloc.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: AppSizes.textMax);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingDefault),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Post Title'),
            Text(post.title ?? '', style: textStyle),
            const Divider(),
            const Text('Post Body'),
            Text(post.body ?? '', style: textStyle),
            const Divider(),
            const Text('Post Id'),
            Text(post.id.toString(), style: textStyle),
            const Divider(),
            const Text('From User'),
            BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                return Text(state.getUserNameById(post.userId ?? 0), style: textStyle);
              },
            ),
          ],
        ),
      ),
    );
  }
}
