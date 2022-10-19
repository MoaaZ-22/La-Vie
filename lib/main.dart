
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/modules/Home_Screen/home_screen.dart';
import 'package:la_vie/modules/Login_Register/login_register_screen.dart';
import 'package:la_vie/shared/bloc_observer.dart';
import 'package:la_vie/shared/components/const.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import 'package:la_vie/shared/network/local/cache_helper.dart';
import 'package:la_vie/shared/network/remote/dio_helper.dart';
import 'package:la_vie/shared/styles/color.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  accessToken = CacheHelper.getDataIntoShPre(key: 'accessToken');
  late Widget widget;

  if(accessToken != null) {
    widget = const HomeScreen();
  } else {
    widget = const LoginRegisterScreen();
  }
  print(accessToken);

  Bloc.observer = LaVieBlocObserver();
  runApp(LaVieApp(startWidget: widget,));
}

class LaVieApp extends StatelessWidget {

  final Widget startWidget;

  const LaVieApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context) => LaVieAppCubit()..getAllProducts()..getPlants()..getSeeds()..getTools()..getUserData()..getMyForums()..getAllForums()..getRecentSearchItems()..createDataBase()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: ThemeData(
          textTheme: TextTheme(
            caption: TextStyle(fontSize: 14,fontFamily: 'RobotoMedium',color: defaultGreyColor)
          ),
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: defaultColor,
              statusBarIconBrightness: Brightness.light
            )
          )
        ),
      ),
    );
  }
}


