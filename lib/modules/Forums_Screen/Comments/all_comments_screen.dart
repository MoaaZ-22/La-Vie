// ignore_for_file: sized_box_for_whitespace, avoid_print


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';
import '../../../shared/styles/color.dart';
import '../../../shared/styles/icons.dart';

class AllCommentsScreen extends StatelessWidget {
  final int intIndex;
  const AllCommentsScreen({Key? key, required this.intIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = LaVieAppCubit.get(context);
    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
      listener: (context, state) {
        if (state is LaVieCreateCommentsSuccessState && appCubit.forumsIndex == true) {
          appCubit.commentTextController.clear();
          appCubit.getAllForums();
        }
        if (state is  LaVieCreateCommentsErrorState)
          {
            showToast(message:'comment should not be empty', state: ToastStates.error);
          }
      },
      builder: (context, state) {
        String? dateFormat;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
            backgroundColor: Colors.white,
            title: const Text(
              'Comments',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoRegular',
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
            leading: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                IconlyBroken.arrow_left_2,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: ConditionalBuilder(
              condition: true,
              builder: (context) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: appCubit.allForumsModel!.data[intIndex].forumComments.length,
                        itemBuilder: (context, index)
                        {
                          dateFormat = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(appCubit.allForumsModel!.data[intIndex].forumComments[index].createdAt));

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 22.0,
                                    backgroundImage: NetworkImage(
                                        'https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png'),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade200,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'La Vie User',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            appCubit.allForumsModel!.data[intIndex].forumComments[index].comment,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'HarryHeavySqueezed',
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 52),
                                child: Text(dateFormat!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'HarryHeavySqueezed',
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      ),
                    ),
                    Container(
                      height: 55,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5.0, left: 5.0),
                              child: defaultTextFormFiled(
                                  controller: appCubit.commentTextController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Address Must Not be Empty';
                                    }
                                    return null;
                                  },
                                  isPassword: false),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              IconlyBroken.send,
                              color: defaultColor,
                              size: 30,
                            ),
                            onPressed: () {
                              print('********************************************');
                              appCubit.createComments(
                                  comment: appCubit
                                      .commentTextController
                                      .text,
                                  forumId:  appCubit.allForumsModel!.data[intIndex].forumId);

                              // appCubit.getMyForums();
                            },
                            highlightColor: Colors.blue.shade100,
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
              fallback: (context) => Center(
                child: Text(
                  'Be First Comment',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: defaultColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

