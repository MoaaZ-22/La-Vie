// ignore_for_file: sized_box_for_whitespace, avoid_print, use_full_hex_values_for_flutter_colors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../../modules/Login_Register/Login_Register_Cubit/cubit.dart';
import '../../modules/Login_Register/Login_Register_Cubit/states.dart';
import '../Widgets/slide_transition_animation.dart';
import '../cubit/cubit.dart';
import '../styles/color.dart';
import '../styles/icons.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// Function For Navigate To Other Screens
void navigateTo(context, dynamic widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateWithAnimation(context, dynamic widget, AxisDirection direction) =>
    Navigator.push(
      context,
      SlideTransitionAnimation(child: widget, direction: direction),
    );

Future dialogBox(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
          elevation: 2,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              const Text(
                'Quiz Finished !',
                style: TextStyle(
                    color: Color(0xff21CB88),
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Montserrat'),
              ),
              Center(
                // SvgPicture.asset('assets/images/DoneSvg.svg',width: 300,height: 50,)
                // Lottie.asset('assets/LottieLogo1.json'),
                child: Lottie.asset(
                  'assets/donelottie.json',
                  width: double.infinity,
                  height: 100,
                  animate: true,
                  repeat: false,
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 100,
                      child: MaterialButton(
                        height: 45,
                        color: defaultColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Montserrat'),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
// Flutter Toast Components
Future<bool?> showToast(
        {required String message, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

// For Choose Color Of Toast
enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget circularProIndicator() => Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          color: defaultColor,
          strokeWidth: 3,
        ),
      ),
    );

// Login Register

Widget defaultTextFormFiled({
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required bool isPassword,
  IconData? suffixIcon,
  void Function()? suffixIconFunc,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: isPassword,
    style: const TextStyle(
        fontSize: 18, fontFamily: 'JosefinSans', fontWeight: FontWeight.w400),
    decoration: InputDecoration(
      suffixIcon: suffixIcon != null
          ? IconButton(
              color: defaultGreyColor,
              onPressed: suffixIconFunc,
              icon: Icon(suffixIcon))
          : null,
      errorStyle: const TextStyle(fontSize: 10),
      contentPadding:
          const EdgeInsets.only(top: 1, bottom: 1, left: 8, right: 1),
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
  );
}

// Update Profile
Widget updateTextFormFiled({
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required bool isPassword,
  IconData? suffixIcon,
  required String? hintText,
  required String? labelText,
  void Function()? suffixIconFunc,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: isPassword,
    style: const TextStyle(
        fontSize: 18, fontFamily: 'RobotoRegular', fontWeight: FontWeight.w400),
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      suffixIcon: suffixIcon != null
          ? IconButton(
              color: defaultGreyColor,
              onPressed: suffixIconFunc,
              icon: Icon(suffixIcon))
          : null,
      errorStyle: const TextStyle(fontSize: 10),
      contentPadding:
          const EdgeInsets.only(top: 1, bottom: 1, left: 8, right: 1),
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
  );
}

Widget defaultTextButton(
    {double? height,
    required double buttonRadius,
    required String buttonTextOS,
    required void Function()? onPressed}) {
  return Container(
      // padding: const EdgeInsets.only(left: 40, right: 40),
      width: double.infinity,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: 3,
          backgroundColor: defaultColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonTextOS,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontFamily: 'RobotoMedium'),
        ),
      ));
}

Widget logRegDivider({required double width, required double height}) {
  return Container(
    width: width,
    color: Colors.grey.shade300,
    height: height,
  );
}

Widget firstAndLastName({
  required TextEditingController controller,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    style: const TextStyle(
        fontSize: 18, fontFamily: 'JosefinSans', fontWeight: FontWeight.w400),
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      errorStyle: const TextStyle(fontSize: 10),
      contentPadding:
          const EdgeInsets.only(top: 1, bottom: 1, left: 5, right: 1),
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
  );
}

class ReusableSearchTextFiled extends StatelessWidget {
  const ReusableSearchTextFiled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = LaVieAppCubit.get(context);
    return Container(
      decoration: BoxDecoration(
          color: colorOfBackGroundSearch,
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 20,
        cursorColor: Colors.black,
        controller: appCubit.searchTextController,
        onChanged: (title) {
          appCubit.putSearchedItemInMyList(title);
          appCubit.saveSearchToRecent(title);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(8),
          hintText: 'Search',
          hintStyle: TextStyle(
            fontSize: 16,
            fontFamily: 'RobotoRegular',
          ),
          prefixIcon: Icon(
            IconlyBroken.search,
            size: 17,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

Widget registerAndLoginBuildScreen(context, state) {
  var logRegCubit = LaVieLogRegCubit.get(context);
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/loginbackground1.png'))),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.topEnd,
            height: 65,
          ),
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                  height: 60,
                  child: const Text(
                    'La Vie',
                    style: TextStyle(fontFamily: 'MeddonRegular', fontSize: 27),
                  )),
              Container(
                height: 35,
                child: const Image(
                    height: 15.4,
                    width: 23,
                    image: AssetImage('assets/images/Branding.png')),
              )
            ],
          ),
          // const Image(
          //     image: AssetImage('assets/images/Group 1000003302.png')),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 95, right: 114.29),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: ({bool trueOrFalse = true}) {
                    LaVieLogRegCubit.get(context)
                        .changeToggleValue(trueOrFalse);
                    print(LaVieLogRegCubit.get(context).isPressed);
                  },
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: LaVieLogRegCubit.get(context).isPressed
                      ? Column(
                          children: [
                            Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: defaultColor,
                                    fontFamily: 'RobotoMedium',
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 44.5,
                              height: 2.5,
                              color: defaultColor,
                            )
                          ],
                        )
                      : Column(
                          children: [
                            Text('Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: defaultGreyColor,
                                  fontFamily: 'RobotoRegular',
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 44.5,
                              height: 2.5,
                            )
                          ],
                        ),
                ),
                InkWell(
                  onTap: ({bool trueOrFalse = false}) {
                    LaVieLogRegCubit.get(context)
                        .changeToggleValue(trueOrFalse);
                    print(LaVieLogRegCubit.get(context).isPressed);
                  },
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: LaVieLogRegCubit.get(context).isPressed
                      ? Column(
                          children: [
                            Text('Login',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: defaultGreyColor,
                                    fontFamily: 'RobotoRegular')),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 44.5,
                              height: 2.5,
                            )
                          ],
                        )
                      : Column(
                          children: [
                            Text('Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: defaultColor,
                                  fontFamily: 'RobotoMedium',
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 44.5,
                              height: 2.5,
                              color: defaultColor,
                            )
                          ],
                        ),
                ),
              ],
            ),
          ),
          logRegCubit.isPressed
              ? registerBuildForm(context, state)
              : loginBuildForm(context, state),
        ],
      ),
    ),
  );
}

// Register Box
Widget registerBuildForm(context, state) {
  var logRegCubit = LaVieLogRegCubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Form(
      key: logRegCubit.registerFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 38),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      firstAndLastName(
                          controller: logRegCubit.regFirstNameTextController,
                          validator: (value) => logRegCubit.userName(value))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Last Name',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      firstAndLastName(
                          controller: logRegCubit.regLastNameTextController,
                          validator: (value) => logRegCubit.userName(value))
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // Email TextFormFiled
          Padding(
            padding: const EdgeInsets.only(
              left: 35,
              right: 38,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  height: 3,
                ),
                defaultTextFormFiled(
                    isPassword: false,
                    controller: logRegCubit.regEmailTextController,
                    validator: (value) =>
                        logRegCubit.emailRegisterValidation(value)),

                // Password TextFormFiled

                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 3),
                defaultTextFormFiled(
                    isPassword: logRegCubit.isRegisterTrue ? true : false,
                    suffixIconFunc: () {
                      logRegCubit.showPasswordRegisterScreen();
                    },
                    suffixIcon: logRegCubit.isRegisterTrue
                        ? IconlyBroken.show
                        : IconlyBroken.hide,
                    controller: logRegCubit.regPasswordTextController,
                    validator: (value) =>
                        logRegCubit.passwordRegisterValidation(value)),

                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Confirm Password',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 3),
                defaultTextFormFiled(
                    suffixIconFunc: () {
                      logRegCubit.showConfirmPasswordRegisterScreen();
                    },
                    suffixIcon: logRegCubit.isConfirmRegisterTrue
                        ? IconlyBroken.show
                        : IconlyBroken.hide,
                    isPassword:
                        logRegCubit.isConfirmRegisterTrue ? true : false,
                    controller: logRegCubit.regConfirmPasswordTextController,
                    validator: (value) =>
                        logRegCubit.confirmPasswordValidation(value)),

                const SizedBox(
                  height: 30,
                ),
                ConditionalBuilder(
                  condition: state is! LaVieRegisterLoadingState,
                  builder: (BuildContext context) => defaultTextButton(
                      buttonRadius: 5,
                      buttonTextOS: 'Sign Up',
                      height: 46.24,
                      onPressed: () {
                        if (logRegCubit.registerFormKey.currentState!
                            .validate()) {
                          logRegCubit.userRegister(
                              firstName:
                                  logRegCubit.regFirstNameTextController.text,
                              lastName:
                                  logRegCubit.regLastNameTextController.text,
                              email: logRegCubit.regEmailTextController.text,
                              password:
                                  logRegCubit.regPasswordTextController.text);
                        }
                      }),
                  fallback: (BuildContext context) => SizedBox(
                    height: 46.24,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(
                          color: defaultColor, strokeWidth: 5),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    logRegDivider(width: 86, height: 1.5),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'or continue with',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    logRegDivider(width: 86, height: 1.5),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        padding: const EdgeInsets.all(1),
                        minWidth: 1.5,
                        onPressed: () {},
                        child: SvgPicture.asset('assets/images/google.svg')),
                    const SizedBox(
                      width: 20,
                    ),
                    MaterialButton(
                        padding: const EdgeInsets.all(1),
                        minWidth: 1.5,
                        onPressed: () {},
                        child: SvgPicture.asset(
                          'assets/images/facebook.svg',
                          height: 45,
                        )),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

// Login Box
Widget loginBuildForm(context, state) {
  var logRegCubit = LaVieLogRegCubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(left: 35, right: 35, top: 30),
    child: Form(
      key: logRegCubit.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email TextFormFiled
          Text(
            'Email',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 3,
          ),
          defaultTextFormFiled(
              isPassword: false,
              controller: logRegCubit.logEmailTextController,
              validator: (value) => logRegCubit.emailValidation(value)),
          // Password TextFormFiled

          const SizedBox(
            height: 20,
          ),
          Text(
            'Password',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 3),
          defaultTextFormFiled(
              suffixIconFunc: () {
                logRegCubit.showPasswordLoginScreen();
              },
              suffixIcon:
                  logRegCubit.isTrue ? IconlyBroken.show : IconlyBroken.hide,
              isPassword: logRegCubit.isTrue ? true : false,
              controller: logRegCubit.logPasswordTextController,
              validator: (value) => logRegCubit.passwordValidation(value)),
          const SizedBox(
            height: 30,
          ),

          ConditionalBuilder(
            condition: state is! LaVieLoginLoadingState,
            builder: (BuildContext context) => defaultTextButton(
                buttonRadius: 5,
                buttonTextOS: 'Sign In',
                height: 46.24,
                onPressed: () {
                  if (logRegCubit.loginFormKey.currentState!.validate()) {
                    logRegCubit.userLogin(
                        password: logRegCubit.logPasswordTextController.text,
                        email: logRegCubit.logEmailTextController.text);
                    // Save User Token >> Listener
                  }
                }),
            fallback: (BuildContext context) => SizedBox(
              height: 46.24,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(
                    color: defaultColor, strokeWidth: 5),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              logRegDivider(width: 86, height: 1.5),
              const SizedBox(
                width: 5,
              ),
              Text(
                'or continue with',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              const SizedBox(
                width: 5,
              ),
              logRegDivider(width: 86, height: 1.5),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  padding: const EdgeInsets.all(1),
                  minWidth: 1.5,
                  onPressed: () {
                    // var logRegCubit =LaVieLogRegCubit.get(context);
                    // Future.delayed(const Duration(milliseconds: 250),() {
                    //   int firstSpace = logRegCubit.user.displayName.indexOf(" ");
                    //   LaVieLogRegCubit.get(context).signIn().then((value) {
                    //     LaVieLogRegCubit.get(context).userLoginWithGoogle(
                    //         id: logRegCubit.user.id,
                    //         email: logRegCubit.user.email,
                    //         firstName: logRegCubit.user.displayName.substring(0, firstSpace),
                    //         lastName:  logRegCubit.user.displayName..substring(firstSpace).trim()
                    //     );
                    //   });
                    // } ,);
                  },
                  child: SvgPicture.asset('assets/images/google.svg')),
              const SizedBox(
                width: 20,
              ),
              MaterialButton(
                  padding: const EdgeInsets.all(1),
                  minWidth: 1.5,
                  onPressed: () {},
                  child: SvgPicture.asset(
                    'assets/images/facebook.svg',
                    height: 45,
                  )),
            ],
          )
        ],
      ),
    ),
  );
}

// all , Plants , Seeds , Tools
Widget buildCategoryItem(index, context) {
  var appCubit = LaVieAppCubit.get(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        appCubit.catListToggle(index);
      },
      child: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            color: appCubit.selectedIndex == index
                ? Colors.white
                : colorOfBackGroundSearch,
            border: Border.all(
                width: 2,
                color: appCubit.selectedIndex == index
                    ? defaultColor
                    : Colors.white),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            appCubit.categoryName[index],
            style: TextStyle(
                fontSize: appCubit.selectedIndex == index ? 15 : 14,
                color: appCubit.selectedIndex == index
                    ? defaultColor
                    : defaultGreyColor,
                fontFamily: 'Montserrat'),
          ),
        ),
      ),
    ),
  );
}

Widget questionToggleItem(index, context) {
  var appCubit = LaVieAppCubit.get(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        appCubit.catListToggle(index);
      },
      child: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            color: appCubit.selectedIndex == index
                ? Colors.white
                : colorOfBackGroundSearch,
            border: Border.all(
                width: 2,
                color: appCubit.selectedIndex == index
                    ? defaultColor
                    : Colors.white),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            appCubit.categoryName[index],
            style: TextStyle(
                fontSize: appCubit.selectedIndex == index ? 15 : 14,
                color: appCubit.selectedIndex == index
                    ? defaultColor
                    : defaultGreyColor,
                fontFamily: 'Montserrat'),
          ),
        ),
      ),
    ),
  );
}

AppBar cartBlogAppBar(
        {required String title, required void Function()? onPressed}) =>
    AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      // Don't show the leading button
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      centerTitle: true,
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      title: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              color: Colors.black),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: IconButton(
          splashRadius: 26,
          alignment: AlignmentDirectional.center,
          onPressed: onPressed,
          icon: const Icon(
            IconlyBroken.arrow_left,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
    );

// Widget For Comment Shape
Widget buildNotification(context) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10, bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/me2.jpeg'),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.78,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                'MoaaZ Muhammed left 6 comments on Your Post',
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Poppins-Medium', height: 1),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Yesterday at 11:42 PM',
                style: Theme.of(context).textTheme.caption!.copyWith(
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                    color: Colors.grey),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildNotificationWithComment(context) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10, bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/hisoka.jpg'),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.78,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                'Dennis Nedry commented on Isla Nublar SOC2 compliance report',
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Poppins-Medium', height: 1),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 4,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.68,
                    child: const Text(
                        '“ leaves are an integral part of the stem system. They are attached by a continuous vascular system to the rest of the plant so that free exchange of nutrients.”',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Medium',
                          height: 1,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Yesterday at 11:42 PM',
                style: Theme.of(context).textTheme.caption!.copyWith(
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                    color: Colors.grey),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget detailsQrBlog({
  IconData? icon,
  int? bigNumber,
  String? smallNumber,
  String? type,
}) =>
    Row(
      children: [
        Container(
          alignment: AlignmentDirectional.center,
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xffA3000000),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: colorOfBackGroundSearch,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(text: '$bigNumber'),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.top,
                        child: Text(
                          smallNumber!,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        )),
                  ]),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              type!,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            )
          ],
        )
      ],
    );
