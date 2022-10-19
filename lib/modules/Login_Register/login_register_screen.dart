// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/modules/Home_Screen/home_screen.dart';
import 'package:la_vie/modules/Login_Register/Login_Register_Cubit/cubit.dart';
import 'package:la_vie/modules/Login_Register/Login_Register_Cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/const.dart';
import '../../shared/network/local/cache_helper.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LaVieLogRegCubit(),
      child: BlocConsumer<LaVieLogRegCubit, LaVieLogRegStates>(
        listener: (BuildContext context, state) {
          if(state is LaVieLoginSuccessState)
          {
            CacheHelper.saveData(key: 'accessToken', value: state.loginModel.data?.accessToken).then((value) =>
            {

              accessToken = CacheHelper.getDataIntoShPre(key: 'accessToken'),
              LaVieLogRegCubit.get(context).logEmailTextController.clear(),
              LaVieLogRegCubit.get(context).logPasswordTextController.clear(),

              pushReplacementNavigate(context, const HomeScreen())
            });
          }else if (state is LaVieLoginErrorState)
          {
            print('***************************************************');
          }
          // Register Function
          else if (state is LaVieRegisterSuccessState)
          {
            if (state.registerModel.type != null)
            {
              // print(state.registerModel.message);
              // print(state.registerModel.data!.accessToken!);
              CacheHelper.saveData(key: 'accessToken', value: state.registerModel.data?.accessToken).then((value) =>
              {

                accessToken = CacheHelper.getDataIntoShPre(key: 'accessToken'),
                showToast(
                    message: state.registerModel.message!,
                    state:ToastStates.success),
                pushReplacementNavigate(context, const HomeScreen()),
                LaVieLogRegCubit.get(context).regFirstNameTextController.clear(),

                LaVieLogRegCubit.get(context).regEmailTextController.clear(),

                LaVieLogRegCubit.get(context).regPasswordTextController.clear(),

                LaVieLogRegCubit.get(context).regConfirmPasswordTextController.clear(),

              }
              );
            }
            else
            {
              showToast(
                  message: 'password too weak (not meeting regex)',
                  state:ToastStates.error);
            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
            ),
            backgroundColor: Colors.white,
            body: registerAndLoginBuildScreen(context,state)
          );
        },
      ),
    );
  }
}

