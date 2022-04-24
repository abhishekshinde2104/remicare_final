// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, sized_box_for_whitespace, non_constant_identifier_names, unused_import, unused_element, curly_braces_in_flow_control_structures, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remicare/doc_ass/doc_ass_methods.dart';
import 'package:remicare/home_pages/doc_ass_home.dart';
import 'package:remicare/home_pages/login_screen.dart';
import 'package:remicare/home_pages/patient_home.dart';

import '../home_pages/doc_ass_home.dart';
import '../home_pages/patient_home.dart';

class DocAssCreateAccount extends StatefulWidget {
  DocAssCreateAccount({Key? key}) : super(key: key);

  @override
  State<DocAssCreateAccount> createState() => _DocAssCreateAccountState();
}

class _DocAssCreateAccountState extends State<DocAssCreateAccount> {
  final TextEditingController _name = TextEditingController();
  TextEditingController _dob = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  String date = "";
  DateTime selectedDate = DateTime.now();

  String? uid;

  //Function to add new user to Cloud FireStore
  Future<String?> current_userid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uid = user!.uid;
    print(uid);
    return(uid);
    // var db = FirebaseFirestore.instance;
    // db.collection('users').doc(uid).set({
    //   'name': _name.text, 
    //   'dob': "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
    //   'email':_email.text,
    //   'password':_password.text 
    // })
    // .then((value) => print("Account Created"))
    // .catchError((error) => print("Failed to create account: $error"));
    // print("Account added to Cloud Firestore");
  }

  
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050), 
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        //_dob.text="${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 0.5,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios), onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DocAssLoginScreen()),
                      );
                        }),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Welcome to REMICARE",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Create Account to Continue!",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10,bottom: 10),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Full Name", Icons.account_box, _name),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10,bottom: 10),
                    child: Row(
                      children:<Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 0),
                          child: IconButton(
                            onPressed: () => _selectDate(context),
                            icon: Icon(Icons.date_range_rounded),
                            //child: Text('Select date'),
                          ),
                        ),

                      Padding(
                          padding: const EdgeInsets.only(left:0,right: 5),
                          child: Container(
                          width: size.width/1.27,
                          alignment: Alignment.center,
                          child: field(size, 
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                           Icons.date_range_rounded, _dob),
                        ),
                      ),
                      ] 
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10,bottom: 10),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Email", Icons.email_rounded , _email),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10,bottom: 10),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: Pfield(size, "Password", Icons.lock, _password),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  customButton(size),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DocAssLoginScreen()),
                      );
                    },
                      child: Text("Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_name.text.isNotEmpty && _email.text.isNotEmpty && _password.text.isNotEmpty) 
        {
          //CHECK IF THE USERNAME OR EMAIL ID IS ALREADY IN USE OR NOT......
        FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text)
          .then((value){
          print("Account Created! in Aunthetication");
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PatientHome()),
        );
        }).onError((error, stackTrace){
          print("Error ${error.toString()}");
        });

        // uid = current_userid() as String?;

        FirebaseFirestore.instance.collection('users')
        .add({
          //"post_id":uid,
          'name': _name.text, 
          'dob': "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
          'email':_email.text,
          'password':_password.text ,
        })
        .then((value) => print("Account Created in Cloud Firestore"))
        .catchError((error) => print("Failed to create account: $error"));


        

          setState(() {
            isLoading = true;
          });

        } 
        else {
          print("Please enter Fields");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue,
          ),
          alignment: Alignment.center,
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget Pfield(Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        obscureText: true,
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
