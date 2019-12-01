import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_found_pet_prototype/api/abstract_user_api.dart';
import 'package:lost_found_pet_prototype/service_locator.dart';

enum AuthState {
  uninitialized,
  authenticated,
  unauthenticated,
}

class AuthModel {
  final AbstractUserApi userApi = locator<AbstractUserApi>();

  static Stream<FirebaseUser> get authUser$ =>
      FirebaseAuth.instance.onAuthStateChanged;

  Future<void> signOut() async {
    await userApi.signOut();
  }

  Future<FirebaseUser> getAuthUser() async {
    return await userApi.getAuthUser();
  }
}
