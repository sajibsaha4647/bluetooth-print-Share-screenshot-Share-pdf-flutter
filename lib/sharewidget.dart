import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareWidgetsScreen extends StatefulWidget {
  const ShareWidgetsScreen({Key? key}) : super(key: key);

  @override
  State<ShareWidgetsScreen> createState() => _ShareWidgetsScreenState();
}

class _ShareWidgetsScreenState extends State<ShareWidgetsScreen> {

  Uint8List? bytes ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: ()async{
        final controller = ScreenshotController();
        final bytes = await controller.captureFromWidget(
            BuildCard()
        );
        setState(() {
          this.bytes = bytes ;
        });
      }, label: Text("image capture")),
      appBar: AppBar(
        title: Text("share image"),
      ),
      
      body:SingleChildScrollView(
        child: Column(
          children: [
            BuildCard(),
            if(bytes != null)Image.memory(bytes!),

            // ElevatedButton(
            //   child: const Text('Share Assets Folder Image'),
            //   onPressed: () async {
            //     ByteData imagebyte = await rootBundle.load('Assets/Group.png');
            //     final temp = await getTemporaryDirectory();
            //     final path = '${temp.path}/image1.jpg';
            //     File(path).writeAsBytesSync(imagebyte.buffer.asUint8List());
            //     await Share.shareFiles([path], text: 'Image Shared');
            //   },
            // ),

            ElevatedButton(
              child: const Text('Share Image'),
              onPressed: () async {
                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/image.jpg';
                File(path).writeAsBytesSync(bytes!);
                await Share.shareFiles([path], text: 'Image Shared');
              },
            ),
          ],
        ),
      ) ,
    ));
  }

  Widget BuildCard()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset('Assets/Group.png',height: 100,width: 100,),
      Text("data",style: TextStyle(color: Colors.red),),
      Row(
        children: [
          Text("data"),
          Text("data")
        ],
      ),
      Image.asset('Assets/Group.png',height: 100,width: 100,),
    ],
  );

}
