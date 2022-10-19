// ignore_for_file: sized_box_for_whitespace, use_full_hex_values_for_flutter_colors, avoid_print, file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/modules/create_forums_post_screen.dart';
import 'package:la_vie/modules/Forums_Screen/fourm_post.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import 'package:la_vie/shared/cubit/states.dart';
import 'package:la_vie/shared/styles/icons.dart';
import '../../shared/styles/color.dart';
class ForumsScreen extends StatelessWidget {

   const ForumsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
        listener: (context, state) {
          if(state is LaVieCreatePostSuccessState)
            {
            LaVieAppCubit.get(context).getMyForums();
            }
          else if(state is LaVieLikeSuccessState)
            {
              LaVieAppCubit.get(context).getMyForums();
            }
          else if(state is LaVieLikeAllSuccessState)
            {
              LaVieAppCubit.get(context).getAllForums();
            }
        },
        builder: (context, state) {
          var appCubit = LaVieAppCubit.get(context);
          int initialMyStart = appCubit.forumsModel!.data.length;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 60,
              leading: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                    appCubit.forumsIndex = true;
                  },
                  child: const Icon(
                    IconlyBroken.arrow_left_2,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              title: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Discussion Forums',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoRegular',
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Column(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorOfBackGroundSearch,
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: SizedBox(
                        height: 45,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 3,
                            ),
                            Icon(
                              IconlyBroken.search,
                              size: 20,
                              color: defaultGreyColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: defaultGreyColor),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          appCubit.forumsToggle(true);
                        },
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              color: appCubit.forumsIndex == true
                                  ? defaultColor
                                  : Colors.white,
                              border: Border.all(
                                  width: 1,
                                  color: appCubit.forumsIndex == true
                                      ? defaultColor
                                      : const Color(0xff979797)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
                              'All Forums',
                              style: TextStyle(
                                  fontSize:
                                      appCubit.forumsIndex == true ? 12 : 12,
                                  color: appCubit.forumsIndex == true
                                      ? Colors.white
                                      : const Color(0xff979797),
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          appCubit.forumsToggle(false);
                        },
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              color: appCubit.forumsIndex == false
                                  ? defaultColor
                                  : Colors.white,
                              border: Border.all(
                                  width: 1,
                                  color: appCubit.forumsIndex == false
                                      ? defaultColor
                                      : const Color(0xff979797)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
                              'My Forums',
                              style: TextStyle(
                                  fontSize:
                                      appCubit.forumsIndex == false ? 12 : 12,
                                  color: appCubit.forumsIndex == false
                                      ? Colors.white
                                      : const Color(0xff979797),
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                      condition: appCubit.allForumsModel!.data.isNotEmpty,
                      builder: (context) {
                        return appCubit.forumsIndex == true ?
                        Flexible(child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                              // return  buildAllForumsPost(context, appCubit.allForumsModel!.data[index],index);
                              return ForumPost(index: index, forumsData: appCubit.allForumsModel!.data[index]);
                              },
                            shrinkWrap: true,
                            itemCount: 20
                          ),)
                            :
                       appCubit.forumsModel!.data.isEmpty? Padding(
                         padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                         child: Text('Create Your First Post',style: TextStyle(fontSize: 18,color: defaultColor,fontFamily: 'RobotoMedium'),),
                       ):Flexible(child: ListView.builder(
                            controller: appCubit.scrollMyForumsController,
                            itemBuilder: (context, index) {
                              return  ForumPost(index: index, forumsData: appCubit.forumsModel!.data[index],userModel: appCubit.userModel!,);
                                // buildMyForumsPost(context, appCubit.forumsModel!.data[index], appCubit.userModel!,index);
                            },
                            shrinkWrap: true,
                            itemCount: initialMyStart
                        ),);
                      },
                      fallback: (context) {
                        if((appCubit.forumsModel == null))
                        {
                          return Center(child: Text('No Internet Connection Pls Check Your Internet',style: TextStyle(fontSize: 16,color: defaultColor),),);
                        }
                        else {
                          return Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                              child: circularProIndicator());
                        }
                      }
                  )
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  navigateTo(context, const CreateForumsPost());
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: defaultColor,
                    shape: const CircleBorder()),
                child: const Icon(
                  IconlyBroken.plus,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          );
        },
        );
  }
}


