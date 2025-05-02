import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/model/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

final Mydatabase database=Mydatabase();

  List<TaskModel>task = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    database.createDatabase().then((_) {
      getTasks();
    });
  }
  void getTasks()async{

    task = await database.getTasks();
    setState(() {});

  }

  void addTask(){}



     Future<void>pickData()async{
       DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
      lastDate: DateTime(2100),

    );
    if(pickedDate!=null){
     dateController.text= "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')}";
    }
}




    @override
    Widget build(BuildContext context) {
      return Scaffold();
    }
  }
