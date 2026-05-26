import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase;

import 'package:boilerplate/domain/repository/user/user_repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

class UserRepositoryImpl extends UserRepository {
  final SharedPreferenceHelper _sharedPrefsHelper;

  UserRepositoryImpl(
    this._sharedPrefsHelper,
  );

  @override
  Future<User?> login(
    LoginParams params,
  ) async {
    try {
      final credential =
          await firebase.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.username,
        password: params.password,
      );

      if (credential.user != null) {
        return User();
      }

      return null;
    } on firebase.FirebaseAuthException catch (e) {
      String pesan;

      switch (e.code) {
        case "user-not-found":
          pesan = "Email tidak ditemukan";

          break;

        case "wrong-password":
          pesan = "Password salah";

          break;

        case "invalid-email":
          pesan = "Format email salah";

          break;

        case "invalid-credential":
          pesan = "Email atau password salah";

          break;

        default:
          pesan = e.message ?? "Login gagal";
      }

      throw Exception(
        pesan,
      );
    }
  }

  @override
  Future<void> saveIsLoggedIn(
    bool value,
  ) {
    return _sharedPrefsHelper.saveIsLoggedIn(value);
  }

  @override
  Future<bool> get isLoggedIn {
    return _sharedPrefsHelper.isLoggedIn;
  }
}
