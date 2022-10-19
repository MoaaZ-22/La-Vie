// ignore_for_file: sized_box_for_whitespace, avoid_print
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/modules/Cart_Screen/cart_screen.dart';
import 'package:la_vie/modules/Question_Screen/question_screen.dart';
import 'package:la_vie/shared/cubit/states.dart';
import '../Forums_Screen/Forums_Screen.dart';
import '../Notification_Screen/notification_screen.dart';
import '../Profile_Screen/profile_screen.dart';
import '../QR_Code_Screen/qr_code_screen.dart';
import 'home.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/styles/color.dart';
import '../../shared/styles/icons.dart';
import '../Search_Screen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    var appCubit = LaVieAppCubit.get(context);
    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 118,
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: const [
                    SizedBox(
                        height: 60,
                        child: Text(
                          'La Vie',
                          style: TextStyle(
                              fontFamily: 'MeddonRegular',
                              fontSize: 27,
                              color: Colors.black),
                        )),
                    SizedBox(
                      height: 35,
                      child: Image(
                          height: 15.4,
                          width: 23,
                          image: AssetImage('assets/images/Branding.png')),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorOfBackGroundSearch,
                            elevation: 0,
                          ),
                          onPressed: () {
                            print('Search Screen');
                            navigateTo(context, const SearchScreen());
                          },
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: defaultColor,
                            padding: EdgeInsets.zero),
                        onPressed: () {
                          // appCubit.getAllBlogs();
                          navigateTo(context, const CartScreen());
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            IconlyBroken.buy,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: defaultColor,
                              padding: EdgeInsets.zero),
                          onPressed: () {
                            navigateTo(context, const QuestionScreen());
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              IconlyBroken.document,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          body: appCubit.isError
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cant Load Your Data Check internet connection',
                        style: TextStyle(color: defaultColor, fontSize: 16),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: defaultTextButton(
                            buttonRadius: 8,
                            buttonTextOS: 'Refresh',
                            onPressed: () async {
                              appCubit.getAllProducts();
                              appCubit.getAllForums();
                              appCubit.getPlants();
                              appCubit.getMyForums();
                            }),
                      )
                    ],
                  ),
                )
              : ConditionalBuilder(
                  condition: appCubit.allProductModel != null &&
                      appCubit.plantsModel != null &&
                      appCubit.allForumsModel != null &&
                      appCubit.forumsModel != null,
                  builder: (context) {
                    return const Home();
                  },
                  fallback: (context) {
                    return circularProIndicator();
                  }),
          floatingActionButton: Container(
            padding: const EdgeInsets.only(left: 12,top: 12,bottom: 16,right: 12),
            decoration: BoxDecoration(
              color: defaultColor,
              shape: BoxShape.circle
            ),
            child: InkWell(
                onTap: () {
                 appCubit.getAllProducts();
                },
                child: const Icon(
                  IconlyBroken.home,
                  size: 30,
                  color: Colors.white,
                )),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            notchMargin: 8,
            shape: const CircularNotchedRectangle(),
            color: colorOfBackGroundSearch,
            child: Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,

                    ),
                    splashRadius: 25,
                      onPressed:   appCubit.isError ? () {} : () {navigateTo(context, const ForumsScreen());},
                      icon: const Icon(IconlyBroken.leaf)),
                  IconButton(
                    style: IconButton.styleFrom(padding: EdgeInsets.zero,),
                    splashRadius: 25,
                      onPressed: () {navigateTo(context, const QRCodeScreen());
                      appCubit.getAllBlogs();},
                      icon: const Icon(IconlyBroken.scan)),
                  const SizedBox(width: 15,),
                  IconButton(
                      style: IconButton.styleFrom(padding: EdgeInsets.zero,),
                      splashRadius: 25,
                      onPressed: () {navigateTo(context, const NotificationScreen());
                      appCubit.getAllBlogs();},
                      icon: const Icon(IconlyBroken.notification)),
                  IconButton(
                      style: IconButton.styleFrom(padding: EdgeInsets.zero,),
                      splashRadius: 25,
                      onPressed: appCubit.isError ? () {} : () {
                        navigateTo(context, const ProfileScreen());
                        appCubit.getUserData();
                        },
                      icon: const Icon(IconlyBroken.profile)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
