import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_viewer/auth/domain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

part 'authentication_state.dart';
part 'authentication_cubit.freezed.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  late final GithubAuthenticator _githubAuthenticator;
  AuthenticationCubit({required GithubAuthenticator githubAuthenticator})
      : super(const AuthenticationState.initial()) {
    _githubAuthenticator = githubAuthenticator;
  }

  Future<void> authenticate() async {}
}
