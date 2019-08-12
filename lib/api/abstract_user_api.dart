import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractUserApi {
  Stream<FirebaseUser> get authUser;

  Future<FirebaseUser> getAuthUser();

  Future<FirebaseUser> signUp({String email, String password});

  Future<FirebaseUser> signIn({String email, String password});

  Future<void> signOut();
}
