import 'package:flutter/material.dart';
import 'package:la_vie/models/Categories/seeds_model.dart';
import '../../../modules/Home_Screen/product_card.dart';

class SeedsProduct extends StatelessWidget {
  final SeedsModel seedsModel;
  const SeedsProduct({Key? key, required this.seedsModel}) : super(key: key);
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
          if (seedsModel.data![index].imageUrl != null &&
              seedsModel.data![index].price != null) {
            return ProductCard(
              index: index,
              model: seedsModel.data!,
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
