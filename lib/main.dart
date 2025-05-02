import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/screens/home_screen.dart';

void main(){
  runApp(const  todo_list());}


class todo_list extends StatelessWidget {
  const todo_list({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xff100B20)),

        home:home_screen()
    );
  }
}


