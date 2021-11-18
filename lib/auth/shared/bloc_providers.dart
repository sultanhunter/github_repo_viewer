import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_viewer/auth/app/cubits/cubit/authentication_cubit.dart';
import 'package:repo_viewer/auth/app/cubits/cubit/get_credentials_from_storage_cubit.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/secure_credentials_storage.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

final Dio _dio = Dio();
final CredentialStorage _credentialStorage = SecureCredentialsStorage();
final GithubAuthenticator _githubAuthenticator =
    GithubAuthenticator(_credentialStorage, _dio);

final GetCredentialsFromStorageCubit _getCredentialsFromStorageCubit =
    GetCredentialsFromStorageCubit(githubAuthenticator: _githubAuthenticator);

final authBlocProvider = BlocProvider<AuthenticationCubit>(
  create: (context) => AuthenticationCubit(
    githubAuthenticator: _githubAuthenticator,
    getCredentialsFromStorageCubit: _getCredentialsFromStorageCubit,
  ),
);

final getCredentialsBlocProvider = BlocProvider<GetCredentialsFromStorageCubit>(
  create: (context) => _getCredentialsFromStorageCubit,
);
