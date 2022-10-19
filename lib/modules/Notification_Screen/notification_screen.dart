import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/components/components.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.light),
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Text('Notification',style: TextStyle(fontSize: 23, fontFamily: 'RobotoMedium',color: Colors.black),),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildNotification(context),
            logRegDivider(width: double.infinity,height: 1),
            buildNotificationWithComment(context),
            logRegDivider(width: double.infinity,height: 1),
            buildNotification(context),
            logRegDivider(width: double.infinity,height: 1),
            buildNotificationWithComment(context),
            logRegDivider(width: double.infinity,height: 1),
            buildNotification(context),
            logRegDivider(width: double.infinity,height: 1),
            buildNotificationWithComment(context),
            logRegDivider(width: double.infinity,height: 1),
            buildNotification(context),
            logRegDivider(width: double.infinity,height: 1),
            buildNotificationWithComment(context),
            logRegDivider(width: double.infinity,height: 1),
            buildNotification(context),
          ],
        ),
      ),
    );
  }}
