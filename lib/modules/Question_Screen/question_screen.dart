import 'package:flutter/material.dart';
import 'package:la_vie/models/Question_Model/questions_data.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/styles/color.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool isTrue = false;
  PageController quizController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text('Course Exam',style: TextStyle(fontSize: 19,fontFamily: 'RobotoRegular',color: Colors.black),),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 25,right: 18,top: 30),
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: quizController,
              itemCount: question.length,
              onPageChanged: (page)
              {
                setState(() {
                  isTrue = false;
                });
              },
              itemBuilder: (context, index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:  [
                        const Text('Question',style: TextStyle(fontSize: 36,fontFamily: 'RobotoMedium',color: Colors.black),),
                        const SizedBox(width: 8,),
                        Text('${index+1}',style: TextStyle(fontSize: 36,fontFamily: 'RobotoRegular',color: defaultColor),),
                        Text('/5',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 14,color: defaultGreyColor),)
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Text(question[index].question!,style: const TextStyle(fontSize: 20,fontFamily: 'RobotoMedium',color: Colors.black),),
                    const SizedBox(height: 40,),
                    for(int i = 0 ; i < question[index].answers!.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: isTrue ? (){} :
                              () {
                            setState(() {
                              isTrue = true;
                            });
                            if(question[index].answers!.entries.toList()[i].value)
                              {

                              }
                          },
                          child: Container(
                            alignment: AlignmentDirectional.topStart,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 2,
                                    color: defaultColor
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 240,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      question[index].answers!.keys.toList()[i],
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontFamily: 'RobotoMedium'),
                                    ),
                                  ),
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 2,color: defaultColor
                                            )
                                        ),
                                      ),
                                      isTrue? question[index].answers!.entries.toList()[i].value ?
                                      Container(
                                        width: 23,
                                        height: 23,
                                        decoration: BoxDecoration(
                                          color: defaultColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ) :
                                      Container(
                                        width: 23,
                                        height: 23,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ) :
                                      const SizedBox()

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 150,
                          child: defaultTextButton(buttonRadius: 8, buttonTextOS: index == 4 ? 'Finish': 'Next',
                              onPressed: isTrue ? index == 4?
                                  (){
                                Navigator.pop(context);
                              }:() {
                                quizController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
                              }
                          : null
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,)
                  ],
                );
              }),
        )
    );
  }
}
