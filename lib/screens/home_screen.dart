import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_app/db/functions/db_functions.dart';
import 'package:student_app/db/model/data_model.dart';
import 'package:student_app/screens/add_student.dart';
import 'package:student_app/screens/details.dart';
import 'package:student_app/screens/list_student.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          'STUDENT APP',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: search(),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Container(
              child: Image(
                image: AssetImage('image/university.webp'),
                // width: double.infinity,
              ),
            ),
            Flexible(
                flex: 8,
                child: Container(
                  child: Liststudent(),
                )),
            Flexible(
                flex: 1,
                child: Center(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AddStudent();
                        }));
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add student ")),
                ))
          ],
        ),
      )),
    );
  }
}

class search extends SearchDelegate {
  List data = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (BuildContext context, List<StudentModel> studentlist,
            Widget? child) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = studentlist[index];
              String nameval = data.name;
              if ((nameval).contains(query)) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Details(
                            studentdetails: data,
                          );
                        }));
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.image)),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              } else {
                return Container();
              }
            },
            itemCount: studentlist.length,
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (BuildContext context, List<StudentModel> studentlist,
            Widget? child) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = studentlist[index];
              String nameval = data.name;
              if ((nameval).contains((query.trim()))) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Details(
                            studentdetails: data,
                          );
                        }));
                      },
                      title: Text(
                        data.name,
                        style: TextStyle(color: Colors.amber),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.image)),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              } else {
                print('no result');
              }
              return null;
            },
            itemCount: studentlist.length,
          );
        });
  }
}
