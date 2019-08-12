import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_found_pet_prototype/api/abstract_user_api.dart';

class UserApi implements AbstractUserApi {
  final _auth = FirebaseAuth.instance;

  @override
  Stream<FirebaseUser> get authUser {
    return _auth.onAuthStateChanged;
  }

  @override
  Future<FirebaseUser> signUp({String email, String password}) async {
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return user;
  }

  @override
  Future<FirebaseUser> signIn({String email, String password}) async {
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return user;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<FirebaseUser> getAuthUser() async {
    return await _auth.currentUser();
  }
}
