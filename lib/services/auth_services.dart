import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '450436408734-boc9lt5sbnckilhrat3qamodm119vskq.apps.googleusercontent.com',
    scopes: ["email"],
  );

  static AuthService? _instance;

  static AuthService get getInstance {
    _instance ??= AuthService();

    return _instance!;
  }

  // Sign up with email and password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign up failed: ${e.message}');
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign in failed: ${e.message}');
    }
  }

  // Google Sign In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in was canceled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Google sign-in failed: ${e.message}');
    }
  }

  // Anonymous Sign In
  Future<User?> signInWithDemoAccount() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: 'mansi@gmail.com',
        password: '123456',
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign in failed: ${e.message}');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  // Check if user is signed in
  User? get currentUser {
    return _auth.currentUser;
  }
}
