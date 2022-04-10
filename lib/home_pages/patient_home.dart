// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, sized_box_for_whitespace, unused_import, unused_field, prefer_final_fields, unnecessary_this, unused_element, avoid_print

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remicare/doc_ass/authenticate.dart';
import 'package:remicare/doc_ass/temp_chat.dart';
import 'package:remicare/home_pages/login_screen.dart';
import 'package:remicare/home_pages/doc_ass_home.dart';
import 'package:remicare/home_pages/remind_home.dart';
import 'package:remicare/home_pages/store_home.dart';
import 'package:remicare/page_styles/buttons.dart';
import 'package:remicare/page_styles/theme.dart';




const primaryColor = Color(0xFF4e5ae8);



class PatientHome extends StatefulWidget {
  const PatientHome({ Key? key }) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>() ;
  int _currentIndex=0;

  final bottomitems = <Widget>[
    Icon(Icons.home), 
    ImageIcon(
      AssetImage('assets/home_icons/doctor_2.png'),
      size: 30,
    ),
    Icon(Icons.camera),
    Icon(Icons.settings),
    
  ];

  final List<Widget> _otherPages = [
    PatientHome(),
    // AddReminderPage(),
    // RemindHome(),
    // AddReminderPage(),
  ];

  // _changePage(){
  //   return Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => _otherPages[_currentIndex]),
  //   );
  // }

  void onTapBottomNavigationBarItem(int index)
  {
    setState(() {
      _currentIndex=index;
     // _changePage();
    });
  }

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text("Hello, Vishwajeet"),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.settings),
            //   onPressed: (){
    
            //   }, 
            // )
          ],
        ),
        drawer: _addDrawer(),
        body:Column(
          children: <Widget>[
            _addTaskBar(),
            _addDateBar(),
            SizedBox(height: 10,),
            //_showTasks(),
          ],
        ),
        
        bottomNavigationBar:_addBottomNavigationBar(),
        
        
      ),
    );
  }

  _addDateBar(){
  return Container(
    margin: EdgeInsets.only(top: 20,left: 20 ),
    child: DatePicker(
      DateTime.now(),
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: primaryColor,
      selectedTextColor: Colors.white,
      monthTextStyle: GoogleFonts.lato(
        textStyle:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color:Colors.grey
        ),
      ),
      dateTextStyle: GoogleFonts.lato(
        textStyle:TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color:Colors.grey
        ),
      ),
      dayTextStyle: GoogleFonts.lato(
        textStyle:TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color:Colors.grey
        ),
      ),
      onDateChange: (date){
        _selectedDate=date;
      },
      

    ),
  );
}

  _addTaskBar(){
  return Container(
    margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(DateFormat.yMMMMd().format(DateTime.now()),
          style: subHeadingStyle,
        ),
        Text("Today",style: headingStyle,),
        ],
      ),
      MyButton(label: "+Reminder", onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context){
        return RemindHomeScreen();
      }))
      ),

    ],
    ),
  );
}

  _addBottomNavigationBar(){  
    // return CurvedNavigationBar(
    //   key: navigationKey,
    //   backgroundColor: Colors.transparent,
    //   color:Color(0xFF9CA4FA),
    //   buttonBackgroundColor:primaryColor,
    //   height: 60,
    //   index:0,
    //   items: bottomitems,
    //   animationCurve: Curves.easeInOut,
    //   animationDuration: Duration(milliseconds: 700),
    //   onTap:(index)=>setState(() {
    //     this._currentIndex=index;
    //   }), 
    // );
    return BottomNavigationBar(
        //type: BottomNavigationBarType.fixed,
        //iconSize: MediaQuery.of(context).size.width*0.06,
        onTap: onTapBottomNavigationBarItem,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PatientHome()),
                );
              },
              child: Icon(Icons.home)
            ),
            label: "Home",
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => listbuild()),
                );
              },
              child: ImageIcon(
                AssetImage('assets/home_icons/doctor_2.png'),
                size: 30,
              ),
            ),
            label: "Assist",
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: Icon(Icons.camera),
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StoreHomePage(title: 'Storage Page',)),
                );
              },
            ),
            label: "Photo",
            backgroundColor: primaryColor
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: "Profile",
          //   backgroundColor: Colors.blue
          // ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: Icon(Icons.settings),
              onTap: (){
                // Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => const RemindHome()),
                // );
              },
            ),
            label: "Settings",
            backgroundColor: primaryColor,
          ),
        ],
      );
  }

  _addDrawer(){
   return Drawer(
     child: ListView(
          children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Vishwajeet Sawant"), 
          accountEmail:Text("vishi@gmail.com"),
        ),
        ListTile(
        title: const Text('Home'),
        leading: Icon(Icons.home),
        iconColor: Colors.blue,
        onTap: () {
        },
      ),
      ListTile(
        title: const Text('Settings'),
        leading: Icon(Icons.settings),
        iconColor: Colors.blue,
        onTap: () {       
        },
      ),
      ListTile(
        title: const Text('Logout'),
        leading: Icon(Icons.logout),
        iconColor: Colors.blue,
        onTap: () {       
        },
      ),     
      ],
    ),
  );
 }

  _showTasks(){
    return Expanded(
      child:Obx((){
        return ListView.builder(
          //itemCount: _taskController,
          itemBuilder: (_,context){
            print(5);
            return GestureDetector(
              onTap: (){

              },
              child: Container(
                width: 100,
                height: 50,
                color: Colors.green,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text("Something"),
              ),
            );
          },
        );
      })
    );
  }



}

//Drawer
 

