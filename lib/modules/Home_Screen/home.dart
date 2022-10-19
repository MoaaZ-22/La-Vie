import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/shared/cubit/states.dart';
import 'Categories_Widget/all_product.dart';
import 'Categories_Widget/plants.dart';
import 'Categories_Widget/seeds.dart';
import 'Categories_Widget/tools.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = LaVieAppCubit.get(context);
    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
        listener: (context, state){},
      builder: (context, state)
    {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: NotificationListener<OverscrollIndicatorNotification>(onNotification: (overScroll) {overScroll.disallowIndicator();return true;},
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) => buildCategoryItem(index, context),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: appCubit.categoryName.length,),),),
            if (LaVieAppCubit.get(context).selectedIndex == 0)
              AllProduct(allProductModel: LaVieAppCubit.get(context).allProductModel!),
            if (LaVieAppCubit.get(context).selectedIndex == 1)
              PlantProduct(plantsModel: LaVieAppCubit.get(context).plantsModel!,),
            if (LaVieAppCubit.get(context).selectedIndex == 2)
              SeedsProduct(seedsModel: LaVieAppCubit.get(context).seedsModel!),
            if (LaVieAppCubit.get(context).selectedIndex == 3)
              ToolsProduct(toolsModel: LaVieAppCubit.get(context).toolsModel!),
            SizedBox(height: MediaQuery.of(context).size.height*0.13,)
          ],
        ),
      );
    },);
  }
}
