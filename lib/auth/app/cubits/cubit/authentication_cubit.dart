import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repo_viewer/auth/app/cubits/cubit/get_credentials_from_storage_cubit.dart';
import 'package:repo_viewer/auth/domain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

part 'authentication_state.dart';

typedef AuthenticationUriCallBack = Future<Uri> Function(Uri authorizationUrl);

class AuthenticationCubit extends Cubit<AuthenticationState> {
  late final GithubAuthenticator _githubAuthenticator;
  late final GetCredentialsFromStorageCubit _getCredentialsFromStorageCubit;
  late StreamSubscription _streamSubscription;
  AuthenticationCubit(
      {required GithubAuthenticator githubAuthenticator,
      required GetCredentialsFromStorageCubit getCredentialsFromStorageCubit})
      : super(AuthenticationStateInitial()) {
    _getCredentialsFromStorageCubit = getCredentialsFromStorageCubit;
    _githubAuthenticator = githubAuthenticator;
    _streamSubscription =
        _getCredentialsFromStorageCubit.stream.listen((state) {
      state.maybeWhen(
        completed: (credentials) {
          emit(AuthenticationStateAuthenticated());
        },
        orElse: () {
          emit(AuthenticationStateUnauthenticated());
        },
      );
    });
  }

  Future<void> authenticate(
    AuthenticationUriCallBack authenticationCallBack,
  ) async {
    emit(AuthenticationStateLoading());
    final grant = _githubAuthenticator.codeGrant();
    final redirectUrl = await authenticationCallBack(
      _githubAuthenticator.getAuthorizationUrl(grant),
    );
    final failureOrSuccess =
        await _githubAuthenticator.handleAuthoriztionResponse(
      grant,
      redirectUrl.queryParameters,
    );
    failureOrSuccess.fold(
      (l) => emit(AuthenticationStateError(authFailure: l)),
      (r) => emit(AuthenticationStateAuthenticated()),
    );
    grant.close();
  }

  Future<void> signOut() async {
    final failureOrSuccess = await _githubAuthenticator.signOut();
    failureOrSuccess.fold(
      (l) => emit(AuthenticationStateError(authFailure: l)),
      (r) => emit(AuthenticationStateUnauthenticated()),
    );
  }

  void emitAuthenticated() {
    emit(AuthenticationStateAuthenticated());
  }

  // @override
  // AuthenticationState? fromJson(Map<String, dynamic> json) {
  //   final String savedState = json['value'] as String;
  //   if (savedState == 'authenticated') {
  //     return AuthenticationStateAuthenticated();
  //   }
  //   if (savedState == 'unauthenticated') {
  //     return AuthenticationStateUnauthenticated();
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(AuthenticationState state) {
  //   if (state is AuthenticationStateAuthenticated) {
  //     return {'value': 'authenticated'};
  //   }
  //   if (state is AuthenticationStateUnauthenticated) {
  //     return {'value': 'unauthenticated'};
  //   }
  // }
}
