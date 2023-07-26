dependencies:
  cupertino_icons: ^1.0.2
  flutter:
    sdk: flutter
  share_plus: ^7.0.2  // Add this package for sharing data
  http: ^1.1.0  // Add this package for getting urlimage from internet
  file_picker: ^5.3.2  //Add this package for getting files from your device for sharing
  path_provider: ^2.0.15 // Add this package for downloading urlimage 

// Make Sure internet is on while getting image from url function    
--------------------Android Permission---------------------

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.searchingapp">

    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

------------------------Ios Permission----------------------


<dict> 
    <key>UIBackgroundModes</key>
    <array>
       <string>fetch</string>
       <string>remote-notification</string>
    </array>
    <key>NSAppleMusicUsageDescription</key>
    <string>Explain why your app uses music</string>
    <key>UISupportsDocumentBrowser</key>
    <true/>
    <key>LSSupportsOpeningDocumentsInPlace</key>
    <true/>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>Explain why your app uses photo library</string>





import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ShareContentApp extends StatefulWidget {
  const ShareContentApp({super.key});

  @override
  State<ShareContentApp> createState() => _ShareContentAppState();
}

class _ShareContentAppState extends State<ShareContentApp> {

  urlimage()async{
    try{
     const imageurl='https://www.pixelstalk.net/wp-content/uploads/2016/06/Trees-in-the-fall-pictures-desktop.jpg';
     final uri=Uri.parse(imageurl);
     final response=await http.get(uri);
     final bytes=response.bodyBytes;

     final temp=await getTemporaryDirectory();
     final path='${temp.path}/image.png';
     await File(path).writeAsBytes(bytes);
     await Share.shareXFiles([XFile(path)]);
    }on SocketException catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Share Content App',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Share Data',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: Colors.red,
              minWidth: 270,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'SHARE',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              onPressed:urlimage
              //  () async{
                // await Share.share('Hey How are you?');
                // await Share.share('Today is Holiday',subject: 'Regarding Holiday');
                // await Share.share('Check out this video https://youtu.be/4AoFA19gbLo');

              //   final file=await FilePicker.platform.pickFiles(type: FileType.video);
              //   if(file!=null){
              //     final filepath=file.files.first;
              //     await Share.shareXFiles([XFile(filepath.path.toString())]);
              //   }
              // },
            )
          ],
        ),
      ),
    );
  }
}
