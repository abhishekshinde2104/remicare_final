// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remicare/page_styles/colors.dart';
import 'package:remicare/page_styles/text_styles.dart';
import 'package:remicare/reminder/add_reminder.dart';
import 'package:remicare/reminder/reminder_history.dart';


const primaryColor = Color(0xFF4e5ae8);


class RemindHomeScreen extends StatelessWidget {
  const RemindHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REMICARE", style: mainHeading,),
        centerTitle: true,
        toolbarHeight: 50,
        elevation: 0,
      ),
      body: Column(

          children: [
            Container(
              padding: const EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                  const Text("Your Personal Medicine Intake Tracker & Healthcare Assistant",
                    style: TextStyle(color: Colors.black, fontSize: 20, ),
                  ),
                   Container(child: Image.asset("assets/remind/heart1.png", height: 65,),)
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor,

                    ),
                    width: 150,
                    child: TextButton(child: const Text("Add Reminder", 
                    style: const TextStyle(color: Colors.white),), 
                    onPressed: (){
                      //Get.to(AddReminder(), transition: Transition.leftToRightWithFade);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddReminder()),
                      );
                    },
                  ),
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor),
                    width: 150,
                    child: TextButton(child: const Text("Reminder History", 
                    style: TextStyle(color: Colors.white)), 
                    onPressed: (){
                      //Get.to(ReminderHistory(), transition: Transition.leftToRightWithFade);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReminderHistory()),
                      );
                    },
                    ),
                  )
                ],
              ),
            )
          ],
      ),
    );
  }
}
