import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remicare/page_styles/colors.dart';
import 'package:remicare/page_styles/text_styles.dart';
import 'package:remicare/reminder/app.dart';
//import 'package:remicarefinal/app/app.dart';
//import 'package:remicarefinal/utility/colors.dart';
//import 'package:remicarefinal/utility/text_styles.dart';

class ReminderHistory extends StatefulWidget {
  const ReminderHistory({Key? key}) : super(key: key);

  @override
  _ReminderHistoryState createState() => _ReminderHistoryState();
}

class _ReminderHistoryState extends State<ReminderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("REMICARE", style: mainHeading,),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: appVar.reminderHistory.length,
          itemBuilder: (context, index){
            return ReminderListElement(
                medicineName:  appVar.reminderHistory[index].getName,
              timeToTakeMedicine: appVar.reminderHistory[index].getInterval.toString(),
            );
      }),
    );
  }
}


class ReminderListElement extends StatelessWidget {
  String timeToTakeMedicine;
  String medicineName;

   ReminderListElement({Key? key, required this.medicineName,required this.timeToTakeMedicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 75,
        color: backGroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Text(timeToTakeMedicine + " Hrs"),
            ),
            Container(
              child: Text(medicineName),
            ),
            SizedBox(
              height: 40,
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // border: Border.all(
                  //   color: Colors.black,
                  //   width: 2,
                  // ),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, spreadRadius: 1),
                    BoxShadow(color: Colors.black, spreadRadius: 1),
                  ],
                  color: backGroundColor,
                ),
                child: TextButton(child: Text("Delete", style: const TextStyle(color: Colors.white),), onPressed: (){

                },),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
