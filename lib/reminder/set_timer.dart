// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:get/get.dart';
import 'package:remicare/page_styles/colors.dart';
import 'package:remicare/page_styles/text_styles.dart';
import 'package:remicare/reminder/app.dart';
import 'package:remicare/reminder/medicine.dart';
import 'package:remicare/reminder/success_screen.dart';


class SetTime extends StatefulWidget {
  const SetTime({Key? key}) : super(key: key);

  @override
  _SetTimeState createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  String dropdownvalue =  '6 Hours';
  var timer = "Timer";

  // List of items in our dropdown menu
  var items = [
    '6 Hours',
    '8 Hours',
    '12 Hours',
    '24 Hours',
  ];

  @override
  Widget build(BuildContext context) {


    void _selectTime() async {
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _time,
      );
      if (newTime != null) {
        setState(() {
          _time = newTime;
          timer = _time.hour.toString() + " : " + _time.minute.toString();
        });
      }

    }

    return Scaffold(
        backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text("REMICARE", style: mainHeading,),
        centerTitle: true,
        toolbarHeight: 80,
        elevation: 0,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 200,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
      color: Colors.black,
        width: 1,
      ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(child:  Text(timer, style: TextStyle(color: Colors.black)), onPressed: (){
                      _selectTime();
                      timer = _time.hour.toString() + " : " + _time.minute.toString();
                      print(timer);
                      setState(() {
                      });
                    },
                    ),
                    IconButton(onPressed: (){
                      _selectTime();
                      timer = _time.hour.toString() + " : " + _time.minute.toString();
                      setState(() {

                      });
                    }, icon: Icon(Icons.alarm))
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Remind Me  After Every "),
                    ),
                    Padding(padding: const EdgeInsets.all(8),
                    child: DropdownButton(

                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        dropdownvalue = newValue as String;
                        setState(() {
                          print(newValue);
                        });
                      },
                    ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 70,),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: 100,
                child: TextButton(child: Text("Done", style: const TextStyle(color: Colors.black),), onPressed: (){
                  appVar.currentMedicine.interval = int.parse(dropdownvalue.split(" ").first);
                  appVar.reminderHistory.add(new Medicine(
                    medicineName: appVar.currentMedicine.medicineName,
                    interval: appVar.currentMedicine.interval,
                    startTime: timer,
                  ));
                  //Get.to(SuccessScreen(), transition: Transition.leftToRightWithFade);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessScreen()),
                  );
                  FlutterAlarmClock.createAlarm(_time.hour, _time.minute, title: "${appVar.currentMedicine.dosage} of ${appVar.currentMedicine.medicineName}");
                },),
              ),
            ),
          )
        ],
      ),
    );
  }
}
