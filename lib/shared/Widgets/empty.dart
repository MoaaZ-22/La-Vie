import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class Empty extends StatelessWidget {
  final String firstText;
  final String secondText;
  const Empty({Key? key, required this.firstText, required this.secondText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        padding: EdgeInsets.only(left: 10,right: 10,top: MediaQuery.of(context).padding.top*4.5),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children:
        [
          SvgPicture.asset(
              height: 200,
              width: 200,
              'assets/images/NotFound.svg'),
          const SizedBox(height: 30,),
          Text(firstText,textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24,fontFamily: 'RobotoRegular',fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          Text(secondText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18,fontFamily: 'RobotoRegular',color: Colors.grey),),

        ],
      ),
    );
  }
}


class EmptyWithColumn extends StatelessWidget {
  final String firstText;
  final String secondText;
  const EmptyWithColumn({Key? key, required this.firstText, required this.secondText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        SvgPicture.asset(
            height: 200,
            width: 200,
            'assets/images/NotFound.svg'),
        const SizedBox(height: 30,),
        Text(firstText,textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24,fontFamily: 'RobotoRegular',fontWeight: FontWeight.bold),),
        const SizedBox(height: 20,),
        Text(secondText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18,fontFamily: 'RobotoRegular',color: Colors.grey),),
      ],
    );
  }
}

