import 'package:flutter/material.dart';
import 'package:la_vie/models/Categories/tools_model.dart';
import '../../../modules/Home_Screen/product_card.dart';

class ToolsProduct extends StatelessWidget {
  final ToolsModel toolsModel;
  const ToolsProduct({Key? key, required this.toolsModel}) : super(key: key);
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
          if (toolsModel.data![index].imageUrl != null &&
              toolsModel.data![index].price != null) {
            return ProductCard(
              index: index,
              model: toolsModel.data!,
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
