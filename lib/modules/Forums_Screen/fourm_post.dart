// ignore_for_file: use_full_hex_values_for_flutter_colors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/modules/Forums_Screen/Comments/my_comments_screen.dart';

import '../../models/Forums_Model/forum_model.dart';
import '../../models/Profile_Model/user_model.dart';
import 'Comments/all_comments_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/styles/color.dart';
import '../../shared/styles/icons.dart';

class ForumPost extends StatelessWidget {
  final int index;
  final AllForumsData forumsData;
  final UserModel? userModel;
  const ForumPost({Key? key, required this.index, required this.forumsData, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(13),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 1, color: Color(0xff1A000000)),
              top: BorderSide(width: 1, color: Color(0xff1A000000)),
              right: BorderSide(width: 1, color: Color(0xff1A000000)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: CachedNetworkImage(
                      imageUrl: forumsData.user.imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: defaultColor,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 11.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          '${forumsData.user.firstName} ${forumsData.user.lastName}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoRegular'),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'a moment ago',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 11),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                forumsData.title,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'RobotoRegular',
                    fontWeight: FontWeight.bold,
                    color: defaultColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                forumsData.description,
                style:
                Theme.of(context).textTheme.caption!.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl:
            'https://lavie.orangedigitalcenteregypt.com${forumsData.imageUrl}',
            imageBuilder: (context, imageProvider) => Container(
              height: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: defaultColor,
                  strokeWidth: 3,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                if(LaVieAppCubit.get(context).forumsIndex == true)
                {
                  LaVieAppCubit.get(context).addAndRemoveLikeFromALl(forumsData.forumId);
                }
                if(LaVieAppCubit.get(context).forumsIndex == false)
                {
                  LaVieAppCubit.get(context).addAndRemoveLike(forumsData.forumId);                }
              },
              child: Row(
                children: [
                  Icon(
                    IconlyBroken.heart,
                    color: defaultGreyColor,
                    size: 17,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${forumsData.forumLikes.length.toString()} Likes',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 44,
            ),
            InkWell(
              onTap: () {
                print(forumsData.forumId);
                if(LaVieAppCubit.get(context).forumsIndex == true)
                {
                  navigateWithAnimation(context, AllCommentsScreen(intIndex: index),AxisDirection.up);
                }
                if(LaVieAppCubit.get(context).forumsIndex == false)
                  {
                    navigateWithAnimation(context, MyCommentsScreen(intIndex: index),AxisDirection.up);
                  }

              },
              child: Text(
                '${forumsData.forumComments.length.toString()} Replies',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
