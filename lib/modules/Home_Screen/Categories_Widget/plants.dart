// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:la_vie/models/Categories/plants_model.dart';
import '../../../modules/Home_Screen/product_card.dart';

class PlantProduct extends StatelessWidget {
  final PlantsModel plantsModel;
  const PlantProduct({Key? key, required this.plantsModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 3.5,
        crossAxisSpacing: 1.0,
        childAspectRatio: 0.79,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(10, (index) {
          if (plantsModel.data![index].imageUrl != null &&
              plantsModel.data![index].price != null) {
            return ProductCard(
              index: index,
              model: plantsModel.data!,
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
