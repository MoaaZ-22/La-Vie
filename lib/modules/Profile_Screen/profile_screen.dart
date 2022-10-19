// ignore_for_file: use_full_hex_values_for_flutter_colors, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import '../../shared/styles/color.dart';
import 'profile.dart';
import '../../shared/cubit/states.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
        builder: (context, state) {
          var appCubit = LaVieAppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: ConditionalBuilder(
                  condition: appCubit.userModel != null,
                  builder: (context)
                  {
                    return Profile( userModel: appCubit.userModel!,);
                  },
                  fallback: (context) {
                    if((appCubit.userModel == null))
                    {
                      return Center(child: Text('No Internet Connection Pls Check Your Internet',style: TextStyle(fontSize: 16,color: defaultColor),),);
                    }
                    else {
                      return circularProIndicator();
                    }
                  }
              ),
            ),
          );
        },
        listener: (context, state)
        {
          if (state is LaVieUpdateUserDataSuccessState)
          {
            LaVieAppCubit.get(context).getUserData();
          }
          if(state is LaVieProfileImagePickedSuccessState)
            {
              showToast(message: 'No Image Selected', state: ToastStates.error);
            }
        }
    );
  }
}
