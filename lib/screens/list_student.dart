import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app/db/functions/db_functions.dart';
import 'package:student_app/screens/details.dart';
import 'package:student_app/screens/edit_student.dart';

import '../db/model/data_model.dart';

class Liststudent extends StatelessWidget {
  const Liststudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext ctx, List<StudentModel> studentList,
              Widget? child) {
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                return Card(
                  color: Colors.amber,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(File(data.image)),
                          radius: 25,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name:${data.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            Text(
                              'Age:${data.age}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            Text(
                              'Address:${data.address}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            Text(
                              'Mobile:+91 ${data.phone}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        trailing: SizedBox(
                          width: 96,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return EditStudent(student: data);
                                    }));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx1) {
                                          return AlertDialog(
                                            title:
                                                Text("Do you want to delete?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    deleteStudent(data.id!);
                                                    deleteButtonClickedYes(ctx);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Yes")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("No"))
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(
                  height: 3,
                );
              },
              itemCount: studentList.length,
            );
          },
        ),
      )),
    );
  }

  deleteButtonClickedYes(ctx) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text("Successfully Deleted"),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
