
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../application/auth_provider.dart';
import '../application/auth_state.dart';

part 'firebase_auth_service.g.dart';

@riverpod
class FirebaseAuthService extends _$FirebaseAuthService {
  @override
  AuthState build() {
    return const AuthState(LoadingStateEnum.initial, null);
  }

  Future<void> sigInInUserWithEmailAndPassword(
      String email,
      String password,
      ) async {
    state = const AuthState(LoadingStateEnum.loading, null);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AuthState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = AuthState(LoadingStateEnum.error, e);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email,
      String password,
      ) async {
    state = const AuthState(LoadingStateEnum.loading, null);
    try {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AuthState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = AuthState(LoadingStateEnum.error, e);
    }
  }

  Future<void> signOut() async {
    state = const AuthState(LoadingStateEnum.loading, null);

    final authRepository = ref.watch(authRepositoryProvider);
    try {
      await authRepository.signOut();
      state = const AuthState(LoadingStateEnum.success, null);
    } on Exception catch (e) {
      state = AuthState(LoadingStateEnum.error, e);
    }
  }
}
