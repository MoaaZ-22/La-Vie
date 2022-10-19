// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:la_vie/modules/Blogs_Screen/blog_details_screen.dart';
import 'package:la_vie/shared/components/components.dart';
import '../../shared/components/const.dart';
import '../../shared/styles/color.dart';

class BlogCard extends StatelessWidget {
  final List<dynamic>? model;
  final int index;
  const BlogCard({Key? key, required this.model, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: SizedBox(
          height: 160,
          width: 373,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: (){
              print(model![index].plantId);
              navigateTo(context, BlogDetailsScreen(
                  imageUrl: model![index].imageUrl,
                  title: model![index].name
                  , description: model![index].description));
            },
            child: Row(
              children:
              [
                Container(
                  height: 140,
                  width: 120,
                  margin: const EdgeInsets.only(left: 10,right: 13),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: model![index].imageUrl!.isNotEmpty ?
                      NetworkImage('$baseUrl${model![index].imageUrl!}') :
                      const NetworkImage('https://st.depositphotos.com/2934765/54735/v/450/depositphotos_547359972-stock-illustration-photo-available-vector-icon-default.jpg'),
                    ),
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
                Container(
                  width: 185,
                  padding: const EdgeInsets.only(top: 15,bottom: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text('2 days ago',style: TextStyle(fontSize: 13.0,color: defaultColor,fontFamily: 'PoppinsExtraLight',fontWeight: FontWeight.w600),),
                      const SizedBox(height: 8,),
                      Text(model![index].name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 18,color: Colors.black,fontFamily: 'RobotoMedium'),),
                      const SizedBox(height: 15,),
                      Text(model![index].description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 2.5,
                            fontSize: 12.0,color: defaultGreyColor,fontFamily: 'PoppinsExtraLight',fontWeight: FontWeight.w600),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
