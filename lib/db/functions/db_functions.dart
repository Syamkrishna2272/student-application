import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_app/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

late Database _db;

Future<void> initializeDataBase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,age TEXT, address TEXT, phone TEXT,image TEXT)');
    },
  );
}

Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
      'INSERT INTO student (name,age,address,phone,image)VALUES (?,?,?,?,?)',
      [value.name, value.age, value.address, value.phone, value.image]);
  getAllStudent();
}

Future<void> getAllStudent() async {
  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);
  studentListNotifier.value.clear();
  _values.forEach((map) {  
    final student = StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
  });
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  await _db.delete('student', where: 'id=?', whereArgs: [id]);

  getAllStudent();
}

Future<void> editStudent(int id, String name, String age, String address,
    String phone, String image) async {
  final data = {
    'name': name,
    'age': age,
    'address': address,
    'phone': phone,
    'image': image
  };

  await _db.update('student', data, where: 'id=?', whereArgs: [id]);

  getAllStudent();
}
