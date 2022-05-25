// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remicare/page_styles/theme.dart';


class MyInputField extends StatelessWidget {

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({ Key? key, 
  required this.title, 
  required this.hint, 
  this.controller, 
  this.widget, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,style: titleStyle,),
          Container(
            height: 52,
            padding: EdgeInsets.only(left: 14),
            margin: EdgeInsets.only(top:8.0),
            //color: Colors.grey,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children:[
                Expanded(
                  child: TextFormField(
                  //readOnly: ,
                  autofocus:false,
                  cursorColor: Colors.grey,
                  controller: controller,
                  style: subTitleStyle,

                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subTitleStyle,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white38,
                        width: 0
                      )
                    ),

                    enabledBorder:UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0
                      )
                    ),

                  ),
                )
                ),
                widget==null?Container():Container(child: widget,)
              ],
            )
          )
        ],
      ),
    );
  }
}