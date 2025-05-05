import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/model/task_model.dart';

class Mydatabase {
  Database? database;


  Future<void> createDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'todo.db');


    database = await openDatabase(path, version: 1,
        onCreate: (db, version) async {
          //print("database created");
          db.execute(
              "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT,data TEXT, time TEXT, status TEXT)");
          //print("table created");
        },

        onOpen: (db) {
          print(dbPath);
          print("database opened");
        }
    );
  }

  Future<void> insertTask(TaskModel task) async {
    await database!.insert(
        'task', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TaskModel>> getTasks() async {
    final List<Map<String, dynamic>> maps = await database!.query('tasks');
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }


  Future<void> updateTaskStatus(int taskId, String status) async {
    final db = await database!;
    await db.update(
      'tasks',
      {'status': status},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  Future<void> deleteTask(int taskId) async {
    final db = await database!;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}




