import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo/app/injection.dart';
import 'package:fudo/app/routes.dart';
import 'package:fudo/presentation/views/auth/bloc/auth_bloc.dart';
import 'package:fudo/presentation/views/posts/bloc/posts_bloc.dart';

class FudoApp extends StatelessWidget {
  const FudoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
        BlocProvider<PostsBloc>(create: (context) => sl<PostsBloc>()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutePath.login,
          routes: routes,
        ),
      ),
    );
  }
}
