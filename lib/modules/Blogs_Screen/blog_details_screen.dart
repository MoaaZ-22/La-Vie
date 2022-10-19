import 'package:flutter/material.dart';
import 'package:la_vie/shared/components/const.dart';
import 'package:la_vie/shared/styles/color.dart';


class BlogDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  const BlogDetailsScreen({Key? key, required this.imageUrl, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 295,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imageUrl.isNotEmpty ?
                NetworkImage('$baseUrl$imageUrl') :
                const NetworkImage('https://st.depositphotos.com/2934765/54735/v/450/depositphotos_547359972-stock-illustration-photo-available-vector-icon-default.jpg'),
              )
            ),
          ),
          Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20,right: 15,bottom: 10,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 23,
                        decoration: TextDecoration.none,
                        fontFamily: 'RobotoMedium',
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16,
                        decoration: TextDecoration.none,
                        fontFamily: 'PoppinsExtraLight',
                        fontWeight: FontWeight.w600,
                        color: defaultGreyColor),
                  ),
                ],
            ),
          ),
              ))
        ],
      ),
    );
  }
}
