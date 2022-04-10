// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';

class listbuild extends StatefulWidget {
  listbuild({Key? key}) : super(key: key);

  @override
  State<listbuild> createState() => _listbuildState();
}

class _listbuildState extends State<listbuild> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController _search = TextEditingController();


    return Scaffold(
      
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: (){})
        ],
      ),

      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                    height: size.height / 14,
                    width: size.width,
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height / 14,
                      width: size.width / 1.15,
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            ListTile(
              leading: Icon(Icons.account_box, color: Colors.black),
              title: Text(
                'Pratiksha',
                style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text('pratiksha@gmail.com'),
            trailing: Icon(Icons.chat, color: Colors.black),
            ),

            SizedBox(
              height: size.height / 100,
            ),
            ListTile(
              leading: Icon(Icons.account_box, color: Colors.black),
              title: Text(
                'Abhishek',
                style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text('abhi@gmail.com'),
            trailing: Icon(Icons.chat, color: Colors.black),
            ),

            SizedBox(
              height: size.height / 100,
            ),
            ListTile(
              leading: Icon(Icons.account_box, color: Colors.black),
              title: Text(
                'Aditi',
                style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text('aditi@gmail.com'),
            trailing: Icon(Icons.chat, color: Colors.black),
            ),

            
          ],
        ),
      ),
    );
  }


} 