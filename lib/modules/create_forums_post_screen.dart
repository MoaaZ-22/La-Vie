// ignore_for_file: avoid_print, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import 'package:la_vie/shared/cubit/states.dart';
import '../shared/styles/color.dart';
import '../shared/styles/icons.dart';

class CreateForumsPost extends StatelessWidget {
  const CreateForumsPost({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var appCubit = LaVieAppCubit.get(context);
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
        listener: (context, state)
        {
          if(state is LaViePostImagePickedErrorState)
          {
            showToast(message: 'No Image Selected', state: ToastStates.error);
          }
          else if(state is LaVieCreatePostSuccessState)
            {
              appCubit.base64string = '';
              titleController.clear();
              descriptionController.clear();
              appCubit.forumsIndex = false;
              Navigator.pop(context);
            }
        },
        builder: (context, state)
        {
          final createPostFormKey = GlobalKey<FormState>();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 60,
              leading: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(IconlyBroken.arrow_left_2,color: Colors.black,size: 30,),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark
              ),
              title: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Create New Post',
                  style: TextStyle(fontSize: 20,fontFamily: 'RobotoRegular',color: Colors.black,fontWeight: FontWeight.w800),),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Form(
                  key: createPostFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                          Center(
                        child: InkWell(
                          onTap: ()
                          {
                            print('Add Post');
                            LaVieAppCubit.get(context).pickPostImage();
                          },
                          child: Container(
                            height: 136,
                            width: 136,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 1,color: defaultColor ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconlyBroken.plus,size: 30,color: defaultColor,),
                                const SizedBox(height: 10,),
                                Text('Add Photo',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: defaultColor),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text('Title',style: Theme.of(context).textTheme.caption,),
                      const SizedBox(height: 5,),
                      defaultTextFormFiled(controller: titleController, validator: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return 'Name Must Not be Empty';
                        }
                        return null;
                      }, isPassword: false),
                      const SizedBox(height: 20,),
                      Text('Description',style: Theme.of(context).textTheme.caption,),
                      const SizedBox(height: 5,),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 8,
                        validator: (value){
                          if (value!.isEmpty)
                          {
                            return 'Name Must Not be Empty';
                          }
                          return null;
                        },
                        controller: descriptionController,
                        style: const TextStyle(fontSize: 18,fontFamily: 'JosefinSans', fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              fontSize: 10
                          ),
                          contentPadding: const EdgeInsets.all(5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: defaultGreyColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: defaultColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: defaultGreyColor)),

                        ),
                      ),
                      const SizedBox(height: 33,),

                      ConditionalBuilder(condition: state is! LaVieCreatePostLoadingState,
                          builder: (context)
                          {
                            return defaultTextButton(
                                height: 50,
                                buttonRadius: 8, buttonTextOS: 'Post', onPressed: ()
                            {
                              if(createPostFormKey.currentState!.validate())
                                {
                                  LaVieAppCubit.get(context).createPost(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                    imageBase64: LaVieAppCubit.get(context).base64string
                                  );
                                }
                            }
                            );
                          }, fallback: (context) => circularProIndicator())
                    ],
                  ),
                ),
              ),
            ),
          );
        }

    );
  }
}
