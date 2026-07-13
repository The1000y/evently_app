import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  Future<User?> createUserAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(name);
      await credential.user!.reload();
      // await credential.user!.sendEmailVerification();
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User?> loginAccount({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      rethrow;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
    if (signInAccount == null) return null;

    GoogleSignInAuthentication authAccount =
        await signInAccount.authentication;
    OAuthCredential accountCredential = GoogleAuthProvider.credential(
      accessToken: authAccount.accessToken,
      idToken: authAccount.idToken,
    );

    return await _auth.signInWithCredential(accountCredential);
  }
}
