import 'package:flutter/material.dart';
import 'package:la_vie/shared/components/const.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import '../../shared/styles/color.dart';
import '../../shared/styles/icons.dart';


class CartItem extends StatelessWidget {
  final Map model;
  const CartItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 2),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: SizedBox(
              height: 150,
              width: 373,
              child: Row(
                children:
                [
                  Container(
                    height: 140,
                    width: 120,
                    margin: const EdgeInsets.only(left: 10,right: 13,bottom: 8),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.network("$baseUrl${model['image']}",fit: BoxFit.cover,),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25,bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.52,
                          child: Text("${model['name']}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'RobotoMedium'),),
                        ),
                        const SizedBox(height: 16,),
                        Text('${model['price']} EGP',style: TextStyle(fontSize: 15.23,color: defaultColor,fontFamily: 'RobotoMedium'),),
                        const Spacer(),
                        SizedBox(
                          width: 180,
                          child: Row(
                            children:
                            [
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
                                          if(model['number'] == 1)
                                          {
                                            LaVieAppCubit.get(context).updateData(number: 1, id: model['id']);
                                          }
                                          else
                                          {
                                            int newNumber = model['number'];
                                            newNumber--;
                                            LaVieAppCubit.get(context).updateData(number: newNumber, id: model['id']);
                                        }

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
                                "${model['number']}",
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
                                        if(model['number'] == 20)
                                        {
                                          LaVieAppCubit.get(context).updateData(number: 20, id: model['id']);
                                        }
                                        else
                                        {
                                          int newNumber = model['number'];
                                          newNumber++;
                                          LaVieAppCubit.get(context).updateData(number: newNumber, id: model['id']);
                                        }
                                      },
                                      child: const Icon(
                                        IconlyBroken.plus,
                                        size: 16,
                                        color: Colors.black,
                                      ))),
                              const Spacer(),
                              IconButton(
                                  splashRadius: 30,
                                  onPressed: (){
                                    LaVieAppCubit.get(context).deleteData(id: model['id']);

                                  }, icon: Icon(IconlyBroken.delete,color: defaultColor,size:25,))
                            ],
                          ),
                        )

                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
