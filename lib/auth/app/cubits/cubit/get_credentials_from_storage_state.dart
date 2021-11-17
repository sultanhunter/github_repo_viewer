part of 'get_credentials_from_storage_cubit.dart';

@freezed
class GetCredentialsFromStorageState with _$GetCredentialsFromStorageState {
  const factory GetCredentialsFromStorageState.initial() = _Initial;
  const factory GetCredentialsFromStorageState.loading() = _Loading;
  const factory GetCredentialsFromStorageState.completed({
    required Credentials credentials,
  }) = _Completed;
  const factory GetCredentialsFromStorageState.error() = _Error;
}
