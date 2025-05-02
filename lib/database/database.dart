import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/model/task_model.dart';

class Mydatabase{
  Database? database;


Future<void>createDatabase()async{
  String dbPath =await getDatabasesPath();
  String path = join(dbPath,'todo.db');


    database =await openDatabase(path,version: 1,
        onCreate: ( db,version)async{
          print("database created");
          db.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT,data TEXT, time TEXT, status TEXT)");
          print("table created");
        },

        onOpen: (db){print(dbPath);
          print("database opened");
        }
    );
  }

  Future<void>insertTask(TaskModel task)async{

  await database!.insert('task', task.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);


  }

}


