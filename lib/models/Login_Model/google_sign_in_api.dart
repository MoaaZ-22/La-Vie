

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninApi
{
  static final _googleSignIn = GoogleSignIn();

  static Future login() => _googleSignIn.signIn();

  static Future logOut() => _googleSignIn.disconnect();
}