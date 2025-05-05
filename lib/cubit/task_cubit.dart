/*
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/cubit/task_state.dart';
import 'package:todo_list/model/task_model.dart';
import 'package:todo_list/database/database.dart';
class TaskCubit extends Cubit<TaskState> {
  final Mydatabase database =Mydatabase();
  TaskCubit():super(TaskInitial());

  Future<List<TaskModel>> getTasks() async {
    emit(TaskLoading());
    try {
      final List<Map<String, dynamic>> maps = await database.query('tasks');
      final tasks = List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
      emit(TaskSuccess(tasks));
      return tasks;
    } catch (e) {
      emit(TaskError(e.toString()));
      return [];
    }
  }

    Future<void> updateTaskStatus(int taskId, String status) async {
      emit(TaskLoading());
      try {
        final db = await database.database;
        await db?.update(
          'tasks',
          {'status': status},
          where: 'id = ?',
          whereArgs: [taskId],
        );
        final tasks =await getTasks();
        emit(TaskSuccess(tasks));
      }catch(error){emit(TaskError(error.toString()));}
    }
    Future<void> deleteTask(int taskId) async {
      emit(TaskLoading());
      try {
        final db = await database.database;
        await db?.delete(
          'tasks',
          where: 'id = ?',
          whereArgs: [taskId],
        );
        final tasks =await getTasks();
        emit(TaskSuccess(tasks));

      }catch(e){emit(TaskError(e.toString()));}
    }
  }






*/
