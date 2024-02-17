import 'dart:io';

import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final studentdetails;
  const Details({super.key, this.studentdetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true ,
        title: Text("Student Details "),
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.teal,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      backgroundImage: FileImage(File(studentdetails.image)),
                      radius: 35,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Name: ${studentdetails.name}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                    ),
                    Text(
                      'Age: ${studentdetails.age}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                    ),
                    Text(
                      'Address: ${studentdetails.address}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                    ),
                    Text(
                      'Phone: ${studentdetails.phone}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
