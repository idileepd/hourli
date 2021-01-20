import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hourli/global_module/utils/hl_config.dart';
import 'package:hourli/global_module/utils/hl_theme.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuthUser = FirebaseAuth.instance;
  // final UserService _userService = UserService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _box = GetStorage();

  // final FirebaseFirestore _firestore = Firestore.instance;

  // // Firebase user one-time fetch
  // Future<FirebaseUser> get firebaseAuthUser => _firebaseAuthUser.currentUser();

  // Firebase user a realtime stream
  FirebaseAuth get firebaseAuthUser => _firebaseAuthUser;

  Stream<DocumentSnapshot> currentUserStream(uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }

  Future<UserCredential> loginWithGoogle() async {
    try {
      // normal google signin
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _firebaseAuthUser.signInWithCredential(credential);
      // print(await authResult.user
      //     .getIdToken()
      //     .then((value) => print(value.token)));

      // var cuser = await _firebaseAuthUser.currentUser();
      // // var test = await cuser.getIdToken();
      // // print("Token is :::");

      // var tokenr = await cuser.getIdToken(refresh: true);

      // String token = tokenr.token;

      // print("CURRENT TOKEN");
      // // debugPrint(token);

      // // while (token.length > 0) {
      // //   int initLength = (token.length >= 500 ? 500 : token.length);
      // //   // print(token.substring(0, initLength));
      // //   int endLength = token.length;
      // //   token = token.substring(initLength, endLength);
      // // }

      // // final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      // // pattern.allMatches(token).forEach((match) => print(match.group(0)));
      // print("FINAL TOKEN::");
      // // print(token);
      // debugPrint(token);

      // await makePostRequest(token);

      // firebase google sign in
      return authResult;
    } catch (e) {
      print('[Auth service] Errro Signin: $e');
      throw 'Error signing in';
    }
  }

  // Stream<UserModel> userModelStream(String uid) {
  //   return _firestore
  //       .collection("users")
  //       .doc(uid)
  //       .snapshots()
  //       .map((DocumentSnapshot documentSnapshot) {
  //     return UserModel.fromDocumentSnapshot(documentSnapshot: documentSnapshot);
  //   });
  // }

  // Sign out
  Future<void> logout() async {
    try {
      await _firestore
          .collection("users")
          .doc(_firebaseAuthUser.currentUser.uid)
          .update({
        "deviceToken": '',
        "deviceTokenStatus": false,
      });
      await _firebaseAuthUser.signOut();
      await _googleSignIn.signOut();
      if (!Get.isDarkMode) {
        Get.changeTheme(HLThemesData.themesMap[HLThemes.dark]);
      }
      _box.write(HLConfig.themeIndexStorageKey, 1);
    } catch (e) {
      print('[Auth service] Errro signout : $e');
      throw e;
    }
  }

  // Determine if Apple Signin is available on device
  // Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();

  // /// Sign in with Google
  // Future<FirebaseUser> googleSignIn() async {
  //   try {
  //     GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  //     GoogleSignInAuthentication googleAuth =
  //         await googleSignInAccount.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.getCredential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     AuthResult result = await _auth.signInWithCredential(credential);
  //     FirebaseUser user = result.user;

  //     // // Update user data
  //     // updateUserData(user);

  //     return user;
  //   } catch (error) {
  //     print(error);
  //     return null;
  //   }
  // }

  // /// Anonymous Firebase login
  // Future<FirebaseUser> anonLogin() async {
  //   AuthResult result = await _auth.signInAnonymously();
  //   FirebaseUser user = result.user;

  //   // updateUserData(user);
  //   return user;
  // }

  // /// Updates the User's data in Firestore on each new login
  // Future<void> updateUserData(FirebaseUser user) {
  //   DocumentReference reportRef = _db.collection('reports').doc(user.uid);

  //   return reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
  //       merge: true);
  // }

}
