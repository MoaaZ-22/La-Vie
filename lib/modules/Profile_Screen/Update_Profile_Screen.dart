// ignore_for_file: no_leading_underscores_for_local_identifiers, file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import 'package:la_vie/shared/cubit/states.dart';
import 'package:la_vie/shared/styles/color.dart';
import 'package:la_vie/shared/styles/icons.dart';


class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
      listener: (context, state){
        if (state is LaVieUpdateUserDataSuccessState)
        {
          LaVieAppCubit.get(context).getUserData();
        }
        else if (state is LaVieUpdateUserDataErrorState)
        {
          showToast(message: LaVieAppCubit.get(context).updateModel!.message!, state: ToastStates.error);
        }
      },
        builder: (context, state)
        {
          final _updateFormKey = GlobalKey<FormState>();

          TextEditingController? updateFirstNameController = TextEditingController();
          TextEditingController? updateLastNameController = TextEditingController();
          TextEditingController? updateEmailController = TextEditingController();
          TextEditingController? updateAddressController = TextEditingController();


          var userData = LaVieAppCubit.get(context).userModel!.data;
          updateFirstNameController.text = userData!.firstName!;
          updateLastNameController.text = userData.lastName!;
          updateEmailController.text = userData.email!;
          updateAddressController.text = userData.address!;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(onPressed: ()
              {
                Navigator.pop(context);
              },
                icon: const Icon(IconlyBroken.arrow_left,size: 24,),color: defaultColor,),
              title: Text('Personal Information',style: TextStyle(fontSize: 22,color: defaultColor),),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 50),
              child: Form(
                key: _updateFormKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(

                    children: [
                      updateTextFormFiled(
                          labelText: 'First Name',
                          hintText: updateFirstNameController.text,
                          controller: updateFirstNameController, validator: (value)
                    {
                    if (value!.isEmpty)
                    {
                    return 'Name Must Not be Empty';
                    }
                    return null;

                    }, isPassword: false),
                      const SizedBox(height: 20,),
                      updateTextFormFiled(
                          labelText:  'Last Name',
                          hintText: updateLastNameController.text,
                          controller: updateLastNameController, validator: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return 'Name Must Not be Empty';
                        }
                        return null;

                      },isPassword: false),
                      const SizedBox(height: 20,),
                      updateTextFormFiled(
                          labelText:  'Email',
                          hintText: updateEmailController.text,
                          controller: updateEmailController, validator: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return 'Email Must Not be Empty';
                        }
                        return null;

                      }, isPassword: false),
                      const SizedBox(height: 20,),
                      updateTextFormFiled(
                          labelText:  'Address',
                          hintText: updateAddressController.text,
                          controller: updateAddressController,validator: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return 'Address Must Not be Empty';
                        }
                        return null;

                      }, isPassword: false),

                      const SizedBox(height: 40,),
                      ConditionalBuilder(
                        condition: state is! LaVieUpdateUserDataLoadingState,
                        builder: (context) => defaultTextButton(buttonRadius: 8, buttonTextOS: 'Save', onPressed: ()
                        {
                          if(_updateFormKey.currentState!.validate())
                            {
                              LaVieAppCubit.get(context)
                                  .updateUserData(firstName: updateFirstNameController.text,
                                  lastName: updateLastNameController.text,
                                  email: updateEmailController.text,
                                  address: updateAddressController.text);
                            }
                        },),
                        fallback: (context) => circularProIndicator(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );},
    );
  }
}
