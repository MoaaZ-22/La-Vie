import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:la_vie/shared/components/const.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/color.dart';
import '../../shared/styles/icons.dart';


class ProductCard extends StatefulWidget {
  final List<dynamic> model;
  final int index;
  const ProductCard({Key? key, required this.index, required this.model}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int currentNumber = 1;
  @override
  Widget build(BuildContext context) {
    var appCubit = LaVieAppCubit.get(context);
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
                                   setState(() {
                                     if(currentNumber == 1)
                                     {
                                       currentNumber = 1;
                                     }
                                     else
                                     {
                                       currentNumber--;
                                     }
                                   });
                                  },
                                  child: const Icon(
                                    IconlyBroken.minus__1_,
                                    size: 16,
                                    color: Colors.black,
                                  ))),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$currentNumber',
                            style: const TextStyle(
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
                                    // Add
                                    setState(() {
                                      if(currentNumber == 20)
                                        {
                                          currentNumber = 20;
                                        }
                                        else
                                          {
                                            currentNumber++;
                                          }
                                    });
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
                        widget.model[widget.index].name!,
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
                        '${widget.model[widget.index].price!} EGP',
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
                          onPressed: () {
                            // print(currentNumber.toString());
                            appCubit.insertDataBase(
                                name: widget.model[widget.index].name!
                                , price: widget.model[widget.index].price!
                                , number: currentNumber
                                , image: widget.model[widget.index].imageUrl
                            );
                            currentNumber = 1;
                            showToast(message: 'Item Added Successfully', state: ToastStates.success);
                          }),
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
            child: CachedNetworkImage(
              imageUrl: '$baseUrl${widget.model[widget.index].imageUrl!}',
              width: 100,
              height: 115,
              fit: BoxFit.contain,
              placeholder: (context,url) => Center(
                child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: defaultColor,strokeWidth: 5,)),
              ),
              errorWidget: (context, url, error) => SvgPicture.asset('assets/images/internetConnection.svg'),

            ))
      ],
    );
  }
}
