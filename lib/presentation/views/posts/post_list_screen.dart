import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo/app/extensions.dart';
import 'package:fudo/app/routes.dart';
import 'package:fudo/app/ui_style.dart';
import 'package:fudo/presentation/utils/toast_handler.dart';
import 'package:fudo/presentation/views/posts/bloc/posts_bloc.dart';
import 'package:fudo/presentation/views/posts/widgets/post_widget.dart';
import 'package:gap/gap.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  bool _showExitWarning = true;

  @override
  void initState() {
    if (context.read<PostsBloc>().state.postList == null) {
      context.read<PostsBloc>().add(GetPostsEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_showExitWarning,
      onPopInvoked: (didPop) async {
        if (_showExitWarning) {
          ToastHandler.showWarningToast('Press back again to exit');
          setState(() {
            _showExitWarning = false;
          });
        }
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.secondaryColor,
            onPressed: () => context.pushNamed(RoutePath.postCreate),
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('Posts'),
          ),
          body: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 1.2,
                  ),
                );
              }
              if (state.postList != null && (state.postList ?? []).isEmpty) {
                return const Center(
                  child: Text('No Posts'),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMin),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search posts...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.borderRadiusDefault),
                        ),
                      ),
                      onChanged: (query) async {},
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Gap(AppSizes.paddingMin),
                      itemCount: (state.postList ?? []).length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final post = state.postList?[index];
                        return PostWidget(post: post);
                      },
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
