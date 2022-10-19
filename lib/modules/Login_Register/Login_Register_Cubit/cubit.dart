// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/models/Login_Model/google_signin_model.dart';
import 'package:la_vie/models/Login_Model/login_model.dart';
import 'package:la_vie/models/Register_Model/register_model.dart';
import 'package:la_vie/modules/Login_Register/Login_Register_Cubit/states.dart';
import 'package:la_vie/shared/network/end_points.dart';
import 'package:la_vie/shared/network/remote/dio_helper.dart';
import '../../../models/Login_Model/google_sign_in_api.dart';


class LaVieLogRegCubit extends Cubit<LaVieLogRegStates>
{

  LaVieLogRegCubit() : super(LaVieLogRegInitialState());

  static LaVieLogRegCubit get(context) => BlocProvider.of(context);


  // initial Value For Toggle Button
  bool isPressed = true;

  // Show Password Login Screen
  bool isTrue = true;

  // Show Password Register Screen
  bool isRegisterTrue = true;

  // Show Password Register Screen Confirm Password
  bool isConfirmRegisterTrue = true;

  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();


  // Login Screen
  TextEditingController logEmailTextController = TextEditingController();
  TextEditingController logPasswordTextController = TextEditingController();

  // Register Screen
  TextEditingController regFirstNameTextController = TextEditingController();
  TextEditingController regLastNameTextController = TextEditingController();
  TextEditingController regEmailTextController = TextEditingController();
  TextEditingController regPasswordTextController = TextEditingController();
  TextEditingController regConfirmPasswordTextController = TextEditingController();


  void changeToggleValue(bool trueOrFalse)
  {

    if(trueOrFalse == true)
    {
      isPressed =true;
    }
    else if(trueOrFalse == false)
    {
      isPressed =false;
    }
    else
    {
      isPressed = !isPressed;
    }
    emit(LaVieLogRegToggleState());
  }

  // Validation Function For Email
  String? emailValidation(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
    {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validation Function For Email
  String? passwordValidation(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    else if(value.trim().length < 8)
    {
      return 'Password must be at least 8 characters in length';
    }
    return null;

  }



  // Register ***************************************************************************

  // Validation Function For User Name
  String? userName(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    else if(value!.length > 27)
    {
      return 'User name length too much';
    }
    return null;
  }

  // Validation Function For Email
  String? emailRegisterValidation(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
    {
      return 'Please enter a valid email address';
    }
    return null;

  }

  // Validation Function For Email
  String? passwordRegisterValidation(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    else if(value.trim().length < 8)
    {
      return 'Password must be at least 8 characters in length';
    }
    return null;

  }



  // Validation Function For Email
  String? confirmPasswordValidation(value)
  {
    if (value!.isEmpty)
    {
      return 'This field is required';
    }
    else if(value != regPasswordTextController.text)
    {
      return 'Not Match';
    }
    else if(value.trim().length < 8)
    {
      return 'Password must be at least 8 characters in length';
    }
    return null;

  }



  // Function For Show And Hide Password In Login Screen
  void showPasswordLoginScreen()
  {
    isTrue = !isTrue;
    emit(ShowPasswordLaVieLoginScreen());
  }

  // *********************************** Show Password And Confirm Password Register Screen

  // Function For Show And Hide Password In Login Screen
  void showPasswordRegisterScreen()
  {
    isRegisterTrue = !isRegisterTrue;
    emit(ShowPasswordLaVieRegisterScreen());
  }



  // Function For Show And Hide Password In Login Screen
  void showConfirmPasswordRegisterScreen()
  {
    isConfirmRegisterTrue = !isConfirmRegisterTrue;
    emit(ShowConfirmPasswordLaVieRegisterScreen());
  }


  // ************************************** Login *********************************************
  LoginModel? loginModel;

  void userLogin({required String password, required String email})
    {

      // Loading State
      emit(LaVieLoginLoadingState());

      DioHelper.postData(url: SIGNIN,lang: 'en', data:
    {
      'password' : password,
      'email' : email,
    }
    ).then((value)
      {

        // Object For Modle Fill it With Data From Post Cuz Validation On Api Response
        loginModel = LoginModel.fromJson(value.data);

        print('${loginModel!.data!.accessToken} ************************** Here');
        print(loginModel!.data!.user!.firstName);
        print(loginModel!.message);

        emit(LaVieLoginSuccessState(loginModel!));
      }
      ).catchError((error)
      {
        if(error is DioError)
          {
            print(error.response);
          }
        emit(LaVieLoginErrorState(error: error.toString()));
      });
    }

  // ************************************** Register *********************************************

  RegisterModel? registerModel;
  void userRegister({required String firstName, required String lastName, required String email, required String password,})
  {

    // Loading State
    emit(LaVieRegisterLoadingState());

    DioHelper.postData(url: SIGNUP, data:
    {
      'firstName' : firstName,
      'lastName' : lastName,
      'email' : email,
      'password' : password,
    }
    ).then((value)
    {

      // Object For Modle Fill it With Data From Post Cuz Validation On Api Response
      registerModel = RegisterModel.fromJson(value.data);

      print('${registerModel!.data!.accessToken} ************************** Here');
      print(registerModel!.data!.user!.firstName);

      emit(LaVieRegisterSuccessState(registerModel!));
    }
    ).catchError((error)
    {
      if(error is DioError)
      {
      }
      emit(LaVieRegisterErrorState(error: error.toString()));
    });
  }

  dynamic user;
  Future signIn() async
  {
    user = await GoogleSigninApi.login();
   print(user.toString());
    emit(LaVieLoginWithGoogleAccountSuccessState(user));
  }
   //************************************************* Login In With Google *********************************************
  GoogleSignInModel? googleSignInModel;
  void userLoginWithGoogle({required String id, required String email, required String firstName, required String lastName})
  {

    // Loading State
    emit(LaVieLoginLoadingState());

    DioHelper.postData(url: SIGNINWITHGOOGLE,lang: 'en', data:
    {
      'id' : id,
      'email' : email,
      'firstName' : firstName,
      'lastName' : lastName,
      'picture' : 'https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png',
    }
    ).then((value)
    {

      // Object For Modle Fill it With Data From Post Cuz Validation On Api Response
      googleSignInModel = GoogleSignInModel.fromJson(value.data);

      print(loginModel!.data!.user!.firstName);


      emit(LaVieLoginWithGoogleSuccessState(googleSignInModel!));
    }
    ).catchError((error)
    {
      if(error is DioError)
      {
        print(error.response);
      }
      emit(LaVieLoginWithGoogleErrorState(error: error.toString()));
    });
  }
}