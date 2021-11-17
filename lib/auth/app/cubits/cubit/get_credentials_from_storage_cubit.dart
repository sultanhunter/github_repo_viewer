import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

part 'get_credentials_from_storage_state.dart';
part 'get_credentials_from_storage_cubit.freezed.dart';

class GetCredentialsFromStorageCubit
    extends Cubit<GetCredentialsFromStorageState> {
  late final GithubAuthenticator _githubAuthenticator;
  GetCredentialsFromStorageCubit({
    required GithubAuthenticator githubAuthenticator,
  }) : super(const GetCredentialsFromStorageState.initial()) {
    _githubAuthenticator = githubAuthenticator;
  }

  Future<void> getSignedInCredentials() async {
    emit(const GetCredentialsFromStorageState.loading());
    final storedCredentials =
        await _githubAuthenticator.getSignedInCredentials();
    if (storedCredentials == null) {
      emit(const GetCredentialsFromStorageState.error());
    }
    if (storedCredentials != null) {
      emit(
        GetCredentialsFromStorageState.completed(
          credentials: storedCredentials,
        ),
      );
    }
  }
}
