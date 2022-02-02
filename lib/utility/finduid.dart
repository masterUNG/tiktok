import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FindUid {
  Future<String> loginUid() async {
    await Firebase.initializeApp();
    var result = FirebaseAuth.instance.currentUser.uid;
    return result;
  }
}
