// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie/modules/Login_Register/Login_Register_Cubit/cubit.dart';
import '../../models/Login_Model/google_sign_in_api.dart';
import '../../models/Profile_Model/user_model.dart';
import '../../shared/components/const.dart';
import '../Login_Register/login_register_screen.dart';
import 'Update_Profile_Screen.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/styles/icons.dart';


class Profile extends StatelessWidget {
  final UserModel userModel;
  const Profile({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: ClipRRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Image(
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.4,
                      image: NetworkImage(userModel.data!.imageUrl!)),
                ),
              ),
            ),
            Container(
              padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      SizedBox(
                        width: 145,
                        height: 125,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          backgroundImage:
                          NetworkImage(userModel.data!.imageUrl!),
                        ),
                      ),
                      IconButton(
                        iconSize: 35,
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey.shade200.withOpacity(0.70),
                          radius: 30,
                          child: const Icon(
                            IconlyBroken.camera,
                            color: Color(0xff1D592C),
                          ),
                        ),
                        onPressed: () {
                          LaVieAppCubit.get(context).pickProfileImage();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${userModel.data!.firstName} ${userModel.data!.lastName}',
                    style: const TextStyle(
                        fontSize: 24.88,
                        decoration: TextDecoration.none,
                        fontFamily: 'RobotoMedium',
                        color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.59,
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffF3FEF1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          width: 40, height: 40, 'assets/images/Group 1264.svg'),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'You have ${userModel.data!.userPoints} points',
                        style: const TextStyle(
                          fontSize: 15.88,
                          fontFamily: 'RobotoMedium',
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 19.88,
                    fontFamily: 'RobotoMedium',
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                PhysicalModel(
                  color: Colors.white,
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 8, top: 15, bottom: 15),
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: const Color(0xff30000000), width: 1),
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            width: 30,
                            height: 30,
                            'assets/images/changeEmailAndNameProfile.svg'),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 17.88,
                            fontFamily: 'OpenSansSemiBold',
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const Spacer(),
                        MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          onPressed: () {
                            navigateTo(context, const UpdateProfileScreen());
                          },
                          child: const Icon(
                            IconlyBroken.arrow_right,
                            size: 30,
                            color: Color(0xff1D592C),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                PhysicalModel(
                  color: Colors.white,
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 8, top: 15, bottom: 15),
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: const Color(0xff30000000), width: 1),
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            width: 30,
                            height: 30,
                            'assets/images/changeEmailAndNameProfile.svg'),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 17.88,
                            fontFamily: 'OpenSansSemiBold',
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const Spacer(),
                        MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          onPressed: () {
                            GoogleSigninApi.logOut();
                            signOut(context);
                          },
                          child: const Icon(
                            IconlyBroken.logout,
                            size: 30,
                            color: Color(0xff1D592C),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 20, top: 5),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconlyBroken.arrow_left,
                    color: Color(0xff1D592C),
                    size: 30,
                  )),
              const Spacer(),
              const Icon(
                Icons.more_horiz,
                color: Color(0xff1D592C),
                size: 30,
              )
            ],
          ),
        )
      ],
    );
  }
}
