import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'app_user.freezed.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    String? email,
    @Default(false) bool emailVerified,
    String? displayName,
  }) = _AppUser;

  factory AppUser.fromUser(User? user) {
    if (user == null) {
      return const AppUser(uid: '');
    }
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      emailVerified: user.emailVerified,
    );
  }
}
