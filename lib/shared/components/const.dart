import 'package:flutter/material.dart';
import '../../modules/Login_Register/login_register_screen.dart';
import '../network/local/cache_helper.dart';

String? accessToken = '';

int navigationBarIndex = 2;

String image64 = '';

String baseUrl = 'https://lavie.orangedigitalcenteregypt.com';

// Function For Navigate To Other Screens And Cant Return
void pushReplacementNavigate(context, dynamic widget) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void signOut(context)
{
  CacheHelper.removeUserData(key: 'accessToken').then((value)
  {
    if (value!)
    {
      pushReplacementNavigate(context , const LoginRegisterScreen());
      navigationBarIndex = 2;
    }
  });
}
