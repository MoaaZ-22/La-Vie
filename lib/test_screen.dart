
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import 'package:la_vie/shared/cubit/states.dart';
import 'package:la_vie/shared/styles/color.dart';
import '../../shared/components/components.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    var appCubit = LaVieAppCubit.get(context);
    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
        listener: (context, state){},
        builder: (context,state){

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false, // Don't show the leading button
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              centerTitle: true,
              backgroundColor: Colors.white,
              toolbarHeight: 80,
              title: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: ReusableSearchTextFiled(),
              ),
            ),
            body:
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Results for ',style: TextStyle(fontSize: 18, fontFamily: 'RobotoRegular', fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.4,
                        child: Text('${appCubit.searchTextController.text} ',
                          maxLines: 1,
                          textWidthBasis: TextWidthBasis.longestLine,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, fontFamily: 'RobotoRegular', fontWeight: FontWeight.bold,color: defaultColor),),
                      ),
                      const Spacer(),
                      Text('${appCubit.searchedList.length}', style: TextStyle(fontSize: 16, fontFamily: 'RobotoRegular', fontWeight: FontWeight.bold,color: defaultColor),),
                      const Text(' Found',style: TextStyle(fontSize: 18, fontFamily: 'RobotoRegular', fontWeight: FontWeight.bold),),

                    ],
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        SvgPicture.asset(
                          height: 200,
                            width: 200,
                            'assets/images/NotFound.svg'),
                        const SizedBox(height: 30,),
                        const Text('Not found',style: TextStyle(fontSize: 24,fontFamily: 'RobotoRegular',fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.',
                            style: TextStyle(fontSize: 18,fontFamily: 'RobotoRegular',color: Colors.grey),),
                        ),

                      ],
                    )
                  ),
                ],
              ),
            )
          );
        });
  }
}
