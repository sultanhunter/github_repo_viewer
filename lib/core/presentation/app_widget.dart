import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_viewer/auth/app/cubits/cubit/authentication_cubit.dart';
import 'package:repo_viewer/auth/app/cubits/cubit/get_credentials_from_storage_cubit.dart';
import 'package:repo_viewer/auth/presentation/sign_in_page.dart';
import 'package:repo_viewer/auth/shared/bloc_providers.dart';
import 'package:repo_viewer/core/presentation/routes/app_router.gr.dart';

class AppWidget extends StatefulWidget {
  AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    context.read<GetCredentialsFromStorageCubit>().getSignedInCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationStateAuthenticated) {
          appRouter.pushAndPopUntil(
            const StarredReposRoute(),
            predicate: (route) => false,
          );
        }
        if (state is AuthenticationStateUnauthenticated ||
            state is AuthenticationStateInitial) {
          appRouter.pushAndPopUntil(
            const SignInRoute(),
            predicate: (route) => false,
          );
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Repo Viewer',
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
