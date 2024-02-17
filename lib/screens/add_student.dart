import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/db/functions/db_functions.dart';
import 'package:student_app/db/model/data_model.dart';

File? image1;
String? image;

class AddStudent extends StatefulWidget {
  AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _addressController = TextEditingController();

  final _phoneController = TextEditingController();

  final GlobalKey<FormState> validation = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: image1 != null
                          ? FileImage(image1!)
                          : AssetImage('image/contacts-icon-png-9.jpg')
                              as ImageProvider,
                      radius: 40,
                    ),
                    Positioned(
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: Text("Choose Image From  "),
                                    actions: [
                                      IconButton(
                                          onPressed: () {
                                            fromCamera();
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(
                                            Icons.camera_alt_rounded,
                                            color: Colors.red,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            fromGallery();
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(
                                            Icons.image,
                                            color: Colors.red,
                                          ))
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.add_a_photo_outlined)),
                      top: 40,
                      left: 40,
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                    key: validation,
                    child: Column(
                      children: [
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Name';
                            }
                          },
                          controller: _nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              suffixIcon: Icon(Icons.person)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Age';
                            }
                          },
                          controller: _ageController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2)
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Age',
                              suffixIcon: Icon(Icons.calendar_month)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Address';
                            }
                          },
                          controller: _addressController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Address',
                              suffixIcon: Icon(Icons.location_city)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Phone number';
                            }
                          },
                          controller: _phoneController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone',
                              suffixIcon: Icon(Icons.phone)),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      onSubmitButtonClicked(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Submit"))
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> onSubmitButtonClicked(context) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _address = _addressController.text.trim();
    final _phone = _phoneController.text.trim();

    if (validation.currentState!.validate() && image1 != null) {
      final _student = StudentModel(
          name: _name,
          age: _age,
          address: _address,
          phone: _phone,
          image: image!);

      addStudent(_student);
      setState(() {
        image1 = null;
      });
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          content: Text("Add Profile Picture ")));
    }
  }

  Future<void> fromGallery() async {
    final img1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img1 != null) {
      setState(() {
        image1 = File(img1.path);
        image = image1!.path;
      });
    }
  }

  Future<void> fromCamera() async {
    final img1 = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img1 != null) {
      setState(() {
        image1 = File(img1.path);
        image = image1!.path;
      });
    }
  }
}
