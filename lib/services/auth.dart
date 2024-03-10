import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kbc_quiz/services/firedb.dart';
import 'package:kbc_quiz/services/localdb.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final usercredential = await _auth.signInWithCredential(credential);

    final User? user = usercredential.user;

    assert(!user!.isAnonymous);

    assert(await user!.getIdToken() != null);

    final User? currentUser = await _auth.currentUser;

    assert(currentUser!.uid == user!.uid);

    print(user);
    await fireDB().createNewUser(user!.displayName.toString(),
        user.email.toString(), user.photoURL.toString(), user.uid.toString());
    await localDB.saveUserID(user.uid);
    await localDB.saveName(user.displayName.toString());
    await localDB.saveUrl(user.photoURL.toString());
  } catch (e) {
    print(e);
    print("Error Occur Durig Sign In");
  }
}

Future<String> signout() async {
  await googleSignIn.signOut();
  await _auth.signOut();
  await localDB.saveUserID("null");
  return "SUCCESS";
}
