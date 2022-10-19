import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/modules/Cart_Screen/cart_item.dart';
import 'package:la_vie/shared/Widgets/empty.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import 'package:la_vie/shared/cubit/states.dart';
import 'package:la_vie/shared/styles/color.dart';
import '../../shared/components/components.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
      listener: (context, state){},
      builder: (context, state){
        var cartList = LaVieAppCubit.get(context).cartList;
        // String totalPrice = cartList.map((e) => e['price'] * e['number']).reduce((value, element) => value+element).toString();
        return Scaffold(
          bottomNavigationBar: cartList.isEmpty? null : Container(
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 20),

            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Total',style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Montserrat'),),
                    const Spacer(),
                    Text(
                      LaVieAppCubit.get(context).totalPrice! ,style: TextStyle(fontSize: 16.5,color: defaultColor,fontFamily: 'RobotoRegular'),),
                    const SizedBox(width: 5,),
                    Text('Egp',style: TextStyle(fontSize: 21,color: defaultColor,fontFamily: 'RobotoRegular'),),
                  ],
                ),
                const Spacer(),
                defaultTextButton(buttonRadius: 8, buttonTextOS: 'Checkout', onPressed: (){},height: 40)
              ],
            ),
          ),
          backgroundColor: Colors.white,
          appBar: cartBlogAppBar(title: 'Cart',onPressed: (){Navigator.pop(context);}),
          body: cartList.isEmpty?
          const EmptyWithColumn(
              firstText: 'Your cart is empty',
              secondText: 'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.',
            )
              : ListView.builder(
              physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => CartItem(model: cartList[index],),
            itemCount: cartList.length,
          ),);
      },
    );
  }
}
