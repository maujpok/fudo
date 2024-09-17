import 'dart:async';
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
  final _searchController = TextEditingController();
  bool _showExitWarning = true;
  Timer? _debounce;

  @override
  void initState() {
    if (context.read<PostsBloc>().state.postListMemory == null) {
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
                    strokeWidth: 1.5,
                  ),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMin),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search posts...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.text = '';
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<PostsBloc>().add(ResetPostsSearchEvent());
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.borderRadiusDefault),
                        ),
                      ),
                      onChanged: (query) async {
                        if (query.isEmpty) {
                          context.read<PostsBloc>().add(ResetPostsSearchEvent());
                        }
                        if (query.length < 3) return;

                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce = Timer(const Duration(milliseconds: 1000), () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<PostsBloc>().add(FilterPostsByUserNameEvent(query: query));
                        });
                      },
                    ),
                  ),
                  if (state.postListFiltered != null && (state.postListFiltered ?? []).isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text('No Posts Found'),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Gap(AppSizes.paddingMin * 1.5),
                        itemCount: (state.postListFiltered ?? []).length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final post = state.postListFiltered?[index];
                          return PostWidget(post: post);
                        },
                      ),
                    ),
                  const Gap(AppSizes.paddingDefault)
                ],
              );
            },
          )),
    );
  }
}
