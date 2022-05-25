

// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_call_super, avoid_unnecessary_containers, avoid_print, unused_element, prefer_final_fields, unused_field, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remicare/home_pages/patient_home.dart';
import 'package:remicare/page_styles/colors.dart';
import 'package:remicare/page_styles/input_field.dart';
import 'package:remicare/page_styles/text_styles.dart';
import 'package:remicare/page_styles/theme.dart';
import 'package:remicare/reminder/app.dart';
import 'package:remicare/reminder/constants.dart';
import 'package:remicare/reminder/set_timer.dart';

import 'package:remicare/globals/globals.dart' as globals;


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
  DateTime _selectedDate = DateTime.now();
  //String _startTime = DateFormat('hh:mm a').format(DateTime.now());
  //String _endTime = "9:30 PM";  
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  String dropdownvalue =  '6 Hours';
  var timer = "Timer";
  //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(_selectedDate);


  
  Future<void> addReminder() async {
   //print("${medicineName.text},${medicineDosage.text},${_selectedDate},${_time}");
    // Call the user's CollectionReference to add a new user
  FirebaseFirestore.instance.collection('users')
  .doc('${globals.currentUUID}')
  .collection('reminders')
  .doc(DateFormat('dd-MM-yyyy').format(_selectedDate))
  .set({
    'med_name': medicineName.text, // John Doe
    'med_dose': medicineDosage.text,
    'date':_selectedDate,
    'time':timer // Stokes and Sons
    //'age': age // 42
  })
  .then((value) => print("${medicineName.text},${medicineDosage.text},${_selectedDate},${_time}"))
  .catchError((error) => print("Failed to add reminder: $error"));
  }

  @override
  void dispose(){
    medicineName.dispose();
    medicineDosage.dispose();
    super.dispose();
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
            Text("Add Tasks",style: headingStyle,),
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
            ///////////////////////////////
            
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: MyInputField(title: "Title", hint: "Enter your Title", controller: medicineName,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: MyInputField(title: "Dosage", hint: "Enter Dosage(mg/ml)", controller: medicineDosage,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: MyInputField(title: "Date", hint: DateFormat('dd-MM-yyyy').format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined,color: Colors.grey,),
                  onPressed: (){
                    _getDateFromUser();
                  },  
                ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: MyInputField(title: "Time:",hint:_time.toString(),
                      widget: IconButton(
                        icon:Icon(Icons.access_time_rounded,color: Colors.grey,) ,
                        onPressed: (){
                          _selectTime();
                          timer = _time.hour.toString() + " : " + _time.minute.toString();
                          //print(timer);
                          setState(() {
                          });
                        },
                      ),),
                    ),
                  ),
                  SizedBox(width: 12,),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 20,right: 20),
                  //     child: MyInputField(title: "End Time:",hint:_endTime,
                  //     widget: IconButton(
                  //       icon:Icon(Icons.access_time_rounded,color: Colors.grey,) ,
                  //       onPressed: (){
                  //         _selectEndTime();
                  //         timer = _time.hour.toString() + " : " + _time.minute.toString();
                  //         //print(timer);
                  //         setState(() {
                  //           _endTime = timer;
                  //           print(_endTime);
                  //         });
                  //       },
                  //     ),),
                  //   ),
                  // ),
                ]
              ),
            ////////////////////////////
            // Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         padding: EdgeInsets.only(left: 25, right: 25),
            //         child: Text("Medicine Name"),
            //       ),
            //       Container(
            //         padding: EdgeInsets.only(left: 25, right: 25),
            //           child: TextFormField(
            //             controller: medicineName,
            //           ),
            //       ),
            //       SizedBox(height: 30,),
            //       Container(
            //         padding: EdgeInsets.only(left: 25, right: 25),
            //         child: Text("Dosage (mg/ml)"),
            //       ),
            //       Container(
            //         padding: EdgeInsets.only(left: 25, right: 25),
            //         child: TextFormField(
            //           controller: medicineDosage,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 30,),
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
            SizedBox(height: 70,),
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

  _getDateFromUser() async{
    DateTime? _pickerDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(DateTime.now().year), 
      lastDate:DateTime(DateTime.now().year+100)
    );

    if (_pickerDate!=null){
      setState(() {
        _selectedDate=_pickerDate;
      });
    }else{
      print("It's null or something is wrong");
    }

  }


  _getTimeFromUser({bool? isStartTime}){
    var _pickedTime= _showTimePicker();
    String _formatedTime = _pickedTime.format(context);
    if(_pickedTime==null){
      print("Time not picked");
    }
  }

  _showTimePicker(){
    return showTimePicker(
    initialEntryMode: TimePickerEntryMode.input,
    context: context, 
    initialTime: TimeOfDay(hour: 9, minute: 10)
  );
  }

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
}


