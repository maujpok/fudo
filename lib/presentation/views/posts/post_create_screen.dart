import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo/app/extensions.dart';
import 'package:fudo/app/ui_style.dart';
import 'package:fudo/presentation/utils/toast_handler.dart';
import 'package:fudo/presentation/views/posts/bloc/posts_bloc.dart';
import 'package:gap/gap.dart';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _userIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingDefault),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Title'),
              TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your post title';
                  }
                  return null;
                },
              ),
              const Gap(AppSizes.paddingDefault),
              const Text('Body'),
              TextFormField(
                controller: _bodyController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your post content';
                  }
                  return null;
                },
              ),
              const Gap(AppSizes.paddingDefault),
              const Text('User Id'),
              TextFormField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ID';
                  }
                  return null;
                },
              ),
              const Gap(AppSizes.paddingMax),
              BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();

                        context.read<PostsBloc>().add(CreatePostEvent(
                              title: _titleController.text,
                              body: _bodyController.text,
                              userId: int.parse(_userIdController.text),
                              onPostCreated: () {
                                context.pop();
                              },
                            ));
                      } else {
                        ToastHandler.showErrorToast('Check your data in form');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: const Color(0XFFFF5023),
                      foregroundColor: Colors.white,
                    ),
                    child: state.loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.2,
                          )
                        : const Text('Submit post'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
