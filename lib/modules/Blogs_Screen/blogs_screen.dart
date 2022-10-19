import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/shared/cubit/cubit.dart';
import 'package:la_vie/shared/cubit/states.dart';
import 'blog_card.dart';
import '../../shared/components/components.dart';

class BlogsScreen extends StatelessWidget {

  const BlogsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LaVieAppCubit, LaVieAppStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        var appCubit = LaVieAppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: cartBlogAppBar(title: 'Blog',onPressed: (){Navigator.pop(context);}),
          body: ConditionalBuilder(
            condition: state is! LaVieGetAllBlogsLoadingState ,
            builder: (context)
            {
              return ListView.builder(
              itemBuilder: (context, index)
              {
                return BlogCard(model: appCubit.getAllBlogsModel!.data!.plants,index: index,);
              },
              itemCount: appCubit.getAllBlogsModel!.data!.plants!.length,
            );
            },
            fallback: (context) => circularProIndicator(),
          ),
        );
      },
    );
  }
}
