import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_viewer/auth/app/cubits/cubit/authentication_cubit.dart';

class StarredReposPage extends StatelessWidget {
  const StarredReposPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('starred')),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                context.read<AuthenticationCubit>().signOut();
              },
              child: Text('sign out')),
        ));
  }
}
