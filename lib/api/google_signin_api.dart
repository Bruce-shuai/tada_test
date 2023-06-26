import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() async {
    try {
      final test = await _googleSignIn.signIn();
      print(test);
      return test;
    } catch (error) {
      return null;
    }
  }

  static Future logout() => _googleSignIn.disconnect();
}
