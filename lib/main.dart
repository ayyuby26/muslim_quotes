import 'package:external_path/external_path.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muslim_quotes/theme/tools.dart';
import 'package:muslim_quotes/util.dart';
import 'package:permission_handler/permission_handler.dart';

final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'navigatorKey');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Muslim Quotes",
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: const Color(0xFF3D5656)),
      ),
      navigatorKey: navigatorKey,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    onLoad(
      () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                "Info",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text("Touch the image to display the options on the image"),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      },
    );
    super.initState();
  }

  bool isSHow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Muslim Quotes"),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            isSHow = !isSHow;
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/quote untuk anak muda.png",
              width: width,
              fit: BoxFit.fitHeight,
            ),
            if (isSHow)
              Container(
                color: Colors.black.withOpacity(.7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      tooltip: "Download",
                      backgroundColor: Colors.white,
                      elevation: 0,
                      onPressed: () async {
                        // const c = Permission.manageExternalStorage;
                        // final isGranted = await c.isGranted;
                        // if (!isGranted) {
                        //   final x = await c.request();
                        //   if (x.isGranted) {
                        //     var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
                        //     await getImageFileFromAssets();
                        //     toast("Saved successfully in $path");
                        //   }
                        //   final cc = await c.isGranted;
                        //   if (await c.isGranted) {
                        //     var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
                        //     await getImageFileFromAssets();
                        //     toast("Saved successfully in $path");
                        //   }
                        // } else {
                        //   if (await c.isGranted) {
                        //     var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
                        //     await getImageFileFromAssets();
                        //     toast("Saved successfully in $path");
                        //   }
                        // }

                        var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
                        await getImageFileFromAssets();
                        toast("Saved successfully in $path");
                      },
                      child: const Icon(
                        Icons.file_download_outlined,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<File> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('assets/quote untuk anak muda.png');
    var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);

    final file = File("$path/quote untuk anak muda.png");
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  // To get public storage directory path
  Future<void> getPath_2() async {}
}
