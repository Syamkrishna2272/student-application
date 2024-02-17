import 'package:flutter/material.dart';
import 'package:student_app/db/functions/db_functions.dart';
import 'package:student_app/db/model/data_model.dart';
import 'package:student_app/screens/home_screen.dart';


Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDataBase();
 
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.teal ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}