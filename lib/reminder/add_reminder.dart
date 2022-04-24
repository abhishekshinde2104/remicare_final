

// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_call_super, avoid_unnecessary_containers, avoid_print, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remicare/home_pages/patient_home.dart';
import 'package:remicare/page_styles/colors.dart';
import 'package:remicare/page_styles/text_styles.dart';
import 'package:remicare/reminder/app.dart';
import 'package:remicare/reminder/constants.dart';
import 'package:remicare/reminder/set_timer.dart';


class AddReminder extends StatefulWidget {
  const AddReminder({Key? key}) : super(key: key);

  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {

  Color pillsColor = Colors.white;
  Color syrupColor = Colors.white;
  Color syringeColor = Colors.white;
  Color selectedColor = backGroundColor;


  TextEditingController medicineName = TextEditingController();
  TextEditingController medicineDosage = TextEditingController();


  CollectionReference<Map<String, dynamic>> reminders = FirebaseFirestore.instance.collection('users').doc('YdPCXc49uJXrfZyp22gH').collection('reminder');
  Future<void> addReminder() {
    // Call the user's CollectionReference to add a new user
    return reminders
        .add({
          'med_name': medicineName.text, // John Doe
          'med_dose': medicineDosage.text, // Stokes and Sons
          //'age': age // 42
        })
        .then((value) => print("Reminder Added"))
        .catchError((error) => print("Failed to add reminder: $error"));
  }

  @override
  void dispose(){
    medicineName.dispose();
    medicineDosage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("REMICARE", style: mainHeading,),
        centerTitle: true,

        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Text("Keep  Calm  &  Take Your Medicines On Time !",
                    style: TextStyle(color: Colors.black, fontSize: 18, ),
                  ),
                  SizedBox(height: 25,),
                   ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: Text("Select Medicine Type", style: TextStyle(fontSize: 18),),
            ),
            SizedBox(height: 25,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      color: pillsColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        selectMedicine(MEDICINE_PILLS);
                      },
                      child: Image.asset("assets/remind/pills.png", height: 65,),
                    ),
                  ),
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      color: syrupColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        selectMedicine(MEDICINE_SYRUP);

                      },
                      child: Image.asset("assets/remind/syrup.png", height: 65,),
                    ),
                  ),
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      color: syringeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        selectMedicine(MEDICINE_SYRINGE);
                      },
                      child: Image.asset("assets/remind/syringe.png", height: 65,),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Text("Medicine Name"),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        controller: medicineName,
                      ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Text("Dosage (mg/ml)"),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      controller: medicineDosage,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor,
              ),
              width: 100,
              child: TextButton(child: Text("Next", 
                style: const TextStyle(color: Colors.white),),
                onPressed: (){
                
                
                addReminder();
                appVar.currentMedicine.medicineName = medicineName.text;
                appVar.currentMedicine.dosage = medicineDosage.text;
                //Get.to(SetTime(), transition: Transition.leftToRightWithFade);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetTime()),
                );
              },),
            ),
          ],
        ),
      ),
    );
  }


  void selectMedicine(String selectedMedicine){
    pillsColor = Colors.white;
    syrupColor = Colors.white;
    syringeColor = Colors.white;
    if (selectedMedicine == MEDICINE_PILLS){
      pillsColor = selectedColor;
    }else if (selectedMedicine == MEDICINE_SYRINGE){
      syringeColor = selectedColor;
    }else {
      syrupColor = selectedColor;
    }
    setState(() {
    });
  }
}


