// ignore_for_file: unused_import, prefer_const_constructors, unused_local_variable

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:remicare/storage/access_file.dart';
import 'package:remicare/storage/button_widget.dart';
import 'package:remicare/storage/file_upload.dart';
import 'package:remicare/storage/firebase_api.dart';



class StoreHomePage extends StatefulWidget {
  const StoreHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StoreHomePage> createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    final items = <Widget>[
      const Icon(Icons.home, size: 20),
      const Icon(Icons.person, size: 30),
      const Icon(Icons.document_scanner, size: 30),
      const Icon(Icons.favorite, size: 30),
      const Icon(Icons.settings, size: 30),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              const SizedBox(height: 8),
              Text(
                fileName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 48),
              ButtonWidget(
                  text: 'Upload File',
                  icon: Icons.cloud_upload_outlined,
                  onClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UploadApp()),
                    );
                  }),
              const SizedBox(height: 48),
              ButtonWidget(
                text: 'Check Uploaded Files',
                icon: Icons.arrow_forward_rounded,
                onClicked: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FileApp()),
                  );
                },
              ),
              const SizedBox(height: 20),
              // ButtonWidget(
              //   text: 'Upload Files',
              //   icon: Icons.file_upload,
              //   onClicked: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => FileApp()),
              //     );
              //   },
              // ),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: NavigationBar(
      //   destinations: items,
      //   height: 60,
      //   backgroundColor: Colors.transparent,
      // ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    // ignore: avoid_print
    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  Future nextPage() async {}
}
