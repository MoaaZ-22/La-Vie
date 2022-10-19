import 'package:flutter/material.dart';
import 'package:la_vie/modules/Blogs_Screen/blogs_screen.dart';
import 'package:la_vie/shared/components/const.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/color.dart';

class PlantsDetails extends StatelessWidget {
  const PlantsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack
        (
        alignment: AlignmentDirectional.topCenter,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.45,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/Meet the Maker_ Nathalie Gibbins _ Rose & Grey 1.png')
                    )
                  ),
                ),
                Positioned(
                    top: 40,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailsQrBlog(bigNumber: 325,icon: Icons.sunny,smallNumber: '%',type: 'sunLight'),
                    const SizedBox(height: 20,),
                    detailsQrBlog(bigNumber: 415,icon: Icons.sunny,smallNumber: '%',type: 'waterCapacity'),
                    const SizedBox(height: 20,),
                    detailsQrBlog(bigNumber: 512,icon: Icons.sunny,smallNumber: '*',type: 'temperature'),
                  ],
                ))
              ],
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.6,
                decoration: const BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20,right: 15,bottom: 10,top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text(
                        'SNAKE PLANT (SANSEVIERIA)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18,
                            decoration: TextDecoration.none,
                            fontFamily: 'RobotoMedium',
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        'Native to southern Africa ',
                        style: TextStyle(fontSize: 16,
                            decoration: TextDecoration.none,
                            fontFamily: 'PoppinsExtraLight',
                            fontWeight: FontWeight.w600,
                            color: defaultGreyColor),
                      ),
                      const SizedBox(height: 120,),
                      Text(
                        'Native to southern Africa ',
                        style: TextStyle(fontSize: 16,
                            decoration: TextDecoration.none,
                            fontFamily: 'PoppinsExtraLight',
                            fontWeight: FontWeight.w600,
                            color: defaultGreyColor),
                      ),
                      const SizedBox(height: 200,),
                      Text(
                        'Native to southern Africa ',
                        style: TextStyle(fontSize: 16,
                            decoration: TextDecoration.none,
                            fontFamily: 'PoppinsExtraLight',
                            fontWeight: FontWeight.w600,
                            color: defaultGreyColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 40,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.66,
                  child: defaultTextButton(buttonRadius: 8, buttonTextOS: 'All Blog', onPressed:
                      (){
                   pushReplacementNavigate(context, const BlogsScreen());
                  }),
                ))
          ],
      ),
    );
  }
}
