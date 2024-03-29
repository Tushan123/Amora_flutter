import 'package:amora/repositories/auth/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User?> signUp({required PhoneAuthCredential cred}) async {
    final credential = await _firebaseAuth.signInWithCredential(cred);
    final user = credential.user;
    return user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
