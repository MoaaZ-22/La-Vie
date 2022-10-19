// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:la_vie/modules/QR_Code_Screen/details_screen.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/styles/color.dart';
import 'package:la_vie/shared/styles/icons.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? qrViewController;
  @override

  void dispose()
  {
    qrViewController!.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if(Platform.isAndroid)
      {
        await qrViewController?.pauseCamera();
      }
        qrViewController?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          qrView(context),
         barcode != null ? Positioned(top: 80, child: result2()): const SizedBox(),
          Positioned(bottom: 40, child: result())
        ],
      ),
    );
  }


  Widget result2()
  {
    return  Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Colors.grey),
      child: Text("${barcode!.code}",style: const TextStyle(color: Colors.black,fontSize: 15),),
    );
  }
  Widget result() => Container(
    height: 75,
    width: 305,
    decoration: BoxDecoration(
      color: colorOfBackGroundSearch,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor:colorOfBackGroundSearch,
      ),
      onPressed: (){
        navigateWithAnimation(context, const PlantsDetails(), AxisDirection.up);
        qrViewController?.pauseCamera();
        qrViewController?.dispose();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Cherokee Rose (SANSEVIERIA)',style: TextStyle(color: Colors.black, fontFamily: 'RobotoRegular',fontWeight: FontWeight.w600),),
                SizedBox(height: 5,),
                Text('Native to southern Africa',style: TextStyle(fontSize: 14,fontFamily: 'RobotoRegular',fontWeight: FontWeight.w400,color: Colors.black),)
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 15),
            height: 45,
            width: 40,
            decoration: BoxDecoration(
              color: defaultColor,
              shape: BoxShape.circle
            ),
            child: const Icon(IconlyBroken.arrow_right,color: Colors.white,),
          )
        ],
      ),
    ),
  );


  Widget qrView(BuildContext context) => QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderWidth: 6.5,
      borderColor: Colors.white,
      borderRadius: 4,
      borderLength: 95,
      cutOutSize: MediaQuery.of(context).size.width*0.84
    ),
  );

  void onQRViewCreated(QRViewController controller)
  {
    setState(() => qrViewController = controller);
    controller.scannedDataStream.listen((barcode) => setState(() {
      this.barcode;
      print("${barcode.code} *******************************************");
    } ));
  }
}

