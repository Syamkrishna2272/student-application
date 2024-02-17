import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/db/functions/db_functions.dart';
import 'package:student_app/db/model/data_model.dart';
import 'package:student_app/screens/add_student.dart';

class EditStudent extends StatefulWidget {
  final student;
  EditStudent({super.key, required StudentModel this.student});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _addressController = TextEditingController();

  final _phoneController = TextEditingController();

  final GlobalKey<FormState> validation = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _nameController.text = widget.student.name;
    _ageController.text = widget.student.age;
    _addressController.text = widget.student.address;
    _phoneController.text = widget.student.phone;

    super.initState();
  }

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
                        radius: 40,
                        backgroundImage: image1 != null
                            ? FileImage(image1!)
                            : FileImage(File(widget.student.image))
                                as ImageProvider),
                    Positioned(
                        top: 35,
                        left: 38,
                        child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      content: Text("Choose Image From"),
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
                            icon: Icon(Icons.camera_alt_rounded)))
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
                      onSubmitButtonClicked(context, widget.student.id);
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

  Future<void> onSubmitButtonClicked(context, int id) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _address = _addressController.text.trim();
    final _phone = _phoneController.text.trim();

    if (validation.currentState!.validate()&& image1!=null) {
      editStudent(id, _name, _age, _address, _phone, image!);

      Navigator.of(context).pop();
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
