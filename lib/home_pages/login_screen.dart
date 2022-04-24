// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, avoid_print, non_constant_identifier_names, unused_local_variable, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remicare/home_pages/create_account.dart';
import 'package:remicare/doc_ass/doc_ass_methods.dart';
import 'package:remicare/home_pages/doc_ass_home.dart';
import 'package:remicare/home_pages/patient_home.dart';


class DocAssLoginScreen extends StatefulWidget {
  DocAssLoginScreen({Key? key}) : super(key: key);

  @override
  State<DocAssLoginScreen> createState() => _DocAssLoginScreenState();
}

class _DocAssLoginScreenState extends State<DocAssLoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String? uid;
  bool isLoading = false;


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
                    height: size.height / 7,
                  ),
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   width: size.width / 0.5,
                  //   child: IconButton(
                  //       icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
                  // ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    width: size.width / 1.1,
                    // ignore: prefer_const_constructors
                    child: Text(
                      "REMICARE",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Let's Get Started",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "Email", Icons.account_box, _email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: Pfield(size, "Password", Icons.lock, _password),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  GestureDetector(
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DocAssCreateAccount()),
                      );
                      },
                  )
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () async {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.text,
            password: _password.text)
            .then((value){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientHome()),
              );
            }).onError((error, stackTrace){
            print("Error ${error.toString()}");
          });

          final FirebaseAuth auth = FirebaseAuth.instance;
          final User? user = auth.currentUser;
          uid = user!.uid;
          print("Login Successful");
          print(uid);
        } 
        else {
          print("Please fill form correctly");
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
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
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

  Widget Pfield(
    Size size, String hintText, IconData icon, TextEditingController cont) {
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
