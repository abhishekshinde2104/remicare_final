// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remicare/home_pages/remind_home.dart';
import 'package:remicare/page_styles/colors.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text("Reminder  Added  Successfully",
              style: TextStyle(color: Colors.white,
              fontSize: 23,
              ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: Image.asset("assets/remind/success.png", height: 200,),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backGroundColor,
                border: Border.all(color: Colors.black, width: 1)
              ),
              width: 100,
              child: TextButton(child: const Text("Done", style: const TextStyle(color: Colors.white),), onPressed: (){
                //Get.to(RemindHomeScreen(), transition: Transition.downToUp);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RemindHomeScreen()),
                );
              },),
            ),
          ],
        ),
      ),
    );
  }
}
