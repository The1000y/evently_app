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
      throw e;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    GoogleSignInAccount? _signInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication _authAccount =
        await _signInAccount!.authentication;
    OAuthCredential _accountCredential = GoogleAuthProvider.credential(
      accessToken: _authAccount.accessToken,
      idToken: _authAccount.idToken,
    );

    return await _auth.signInWithCredential(_accountCredential);
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}
