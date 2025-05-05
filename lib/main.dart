import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/cubit/task_cubit.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/screens/home_screen.dart';

void main()async{//WidgetsFlutterBinding.ensureInitialized();


  runApp(  todo_list());}


class todo_list extends StatelessWidget {

  const todo_list({super.key,});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider<TaskCubit>(create: (context)=>TaskCubit()..getTasks()
    //
    //     ,child:
    return     MaterialApp(
    theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xff100B20)),

        home:HomeScreen()
     );
         //)
  }
}


