import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import 'package:la_vie/shared/cubit/states.dart';
import 'package:la_vie/shared/styles/color.dart';
import 'package:la_vie/shared/styles/icons.dart';
import '../../shared/Widgets/empty.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
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
              appCubit.searchTextController.text.isNotEmpty?
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
                  appCubit.searchedList.isEmpty ?
                  const Empty(firstText: 'Not found',secondText: 'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.',)
                      :Flexible(
                    child: ListView.builder(
                        itemCount: appCubit.searchedList.length,
                        itemBuilder: (context, index)
                        {
                          return Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: [
                              SizedBox(
                                height: 225,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  color: Colors.transparent,
                                                  width: 86,
                                                  height: 58,
                                                ),
                                                const Spacer(),
                                                Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                        color: colorOfBackGroundSearch),
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets.zero,
                                                            backgroundColor:
                                                            colorOfBackGroundSearch,
                                                            elevation: 0),
                                                        onPressed: () {
                                                        },
                                                        child: const Icon(
                                                          IconlyBroken.minus__1_,
                                                          size: 16,
                                                          color: Colors.black,
                                                        ))),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const Text(
                                                  '1',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                        color: colorOfBackGroundSearch),
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets.zero,
                                                            backgroundColor:
                                                            colorOfBackGroundSearch,
                                                            elevation: 0),
                                                        onPressed: () {
                                                        },
                                                        child: const Icon(
                                                          IconlyBroken.plus,
                                                          size: 16,
                                                          color: Colors.black,
                                                        ))),
                                                const SizedBox(
                                                  width: 5,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              appCubit.searchedList[index].name!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'RobotoMedium',
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${appCubit.searchedList[index].price!} EGP',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            defaultTextButton(
                                                height: 40,
                                                buttonRadius: 10,
                                                buttonTextOS: 'Add To Cart',
                                                onPressed: () {}),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 100,
                                  height: 115,
                                  child: Image(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          'https://lavie.orangedigitalcenteregypt.com${appCubit.searchedList[index].imageUrl!}')))
                            ],
                          );
                        }
                    ),
                  ),
                ],
              ),
            ) :
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appCubit.recentItems.isNotEmpty ?
                    Text('Recent Search\'s',style: TextStyle(fontSize: 14, fontFamily: 'RobotoRegular', fontWeight: FontWeight.w300,color: defaultGreyColor),) : const Text(''),
                    Flexible(
                      child: ListView.builder(
                          itemCount: appCubit.recentItems.length,
                          itemBuilder: (context, index)
                          {
                            return Row(
                              children: [
                                Icon(Icons.watch_later_outlined,color: defaultGreyColor,size: 16,),
                                const SizedBox(width: 5,),
                                Text(appCubit.recentItems[index],style: TextStyle(fontSize: 16,fontFamily: 'RobotoRegular',color: defaultGreyColor),),
                                const Spacer(),
                                IconButton(onPressed: (){
                                  appCubit.removeRecentItem(appCubit.recentItems[index]);
                                }, icon: Icon(Icons.close,size: 16,color: defaultGreyColor,),)
                              ],
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
          );
        });
  }
}
