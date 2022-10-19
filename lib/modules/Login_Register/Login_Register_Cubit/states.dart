import 'package:la_vie/models/Login_Model/google_signin_model.dart';
import 'package:la_vie/models/Login_Model/login_model.dart';

import '../../../models/Register_Model/register_model.dart';

abstract class LaVieLogRegStates{}

class LaVieLogRegInitialState extends LaVieLogRegStates{}

class LaVieLogRegToggleState extends LaVieLogRegStates{}

// ********************************** Login State *********************************************

class LaVieLoginLoadingState extends LaVieLogRegStates{}

class LaVieLoginSuccessState extends LaVieLogRegStates{
  // Model

  final LoginModel loginModel;

  LaVieLoginSuccessState(this.loginModel);


}

class LaVieLoginErrorState extends LaVieLogRegStates{
  final String error;

  LaVieLoginErrorState({required this.error});
}


// Show Password In Login Screen
class ShowPasswordLaVieLoginScreen extends LaVieLogRegStates{}

// ********************************** Login State *********************************************

class LaVieRegisterLoadingState extends LaVieLogRegStates{}

class LaVieRegisterSuccessState extends LaVieLogRegStates{
  // Model

  final RegisterModel registerModel;

  LaVieRegisterSuccessState(this.registerModel);


}

class LaVieRegisterErrorState extends LaVieLogRegStates{
  final String? error;

  LaVieRegisterErrorState({required this.error});
}


// Show Password In Register Screen
class ShowPasswordLaVieRegisterScreen extends LaVieLogRegStates{}

// Show Confirm Password In Register Screen
class ShowConfirmPasswordLaVieRegisterScreen extends LaVieLogRegStates{}

class LaVieLoginWithGoogleAccountSuccessState extends LaVieLogRegStates{

  final dynamic user;

  LaVieLoginWithGoogleAccountSuccessState(this.user);
}

// ********************************** Login With Google *********************************************

class LaVieLoginWithGoogleLoadingState extends LaVieLogRegStates{}

class LaVieLoginWithGoogleSuccessState extends LaVieLogRegStates{
  // Model

  final GoogleSignInModel googleSignInModel;

  LaVieLoginWithGoogleSuccessState(this.googleSignInModel);


}

class LaVieLoginWithGoogleErrorState extends LaVieLogRegStates{
  final String error;

  LaVieLoginWithGoogleErrorState({required this.error});
}
