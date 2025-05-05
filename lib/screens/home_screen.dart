import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_list/cubit/task_cubit.dart';
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

  void addTask()async{
    if(timeController.text.isNotEmpty && dateController.text.isNotEmpty && timeController.text.isNotEmpty)
     {
       TaskModel newTask= TaskModel(
           title: titleController.text, date: dateController.text,
           time: timeController.text, state: 'new'
       );

       await database.insertTask(newTask);
       titleController.clear();
       dateController.clear();
       timeController.clear();

       getTasks();
       Navigator.pop(context);
     }
  }






     Future<void>pickDate()async{
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

Future<void>picktime()async{
    TimeOfDay?picktime =await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picktime !=null ){

      timeController.text ="${picktime.hour.toString().padLeft(2, '0')}:${picktime.minute.toString().padLeft(2, '0')}";


    }

}

void showAddTaskSheet(){

    showModalBottomSheet(context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
        isScrollControlled: true,
        builder: (_)=>Padding(padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
            child:SingleChildScrollView(
                child:Column(mainAxisSize:MainAxisSize.min,children: [
                  Container(
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration:  BoxDecoration(color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Text("Add New Task"),

                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Text',
                          prefixIcon: Icon(Icons.title),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    onTap: pickDate,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),

                    ),
                  ),
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: timeController,
                    readOnly: true,
                    onTap: picktime,
                    decoration: const InputDecoration(
                      labelText: 'Time',
                      prefixIcon: Icon(Icons.access_time_sharp),
                      border: OutlineInputBorder(),

                    ),
                  ),
                  const SizedBox(height:20,),
                  SizedBox(width: double.infinity,height: 50,
                    child: ElevatedButton.icon(onPressed: addTask, icon:  const Icon(Icons.save),
                        label:const Text(("save Task")),
                        style:ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.blueAccent,
                        )
                       ),
                    )
            ],)),
    ),
    );}






    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: const Text("ToDo App"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        
        ),
        body:task.isEmpty ?const Center(
          child: Text(
            'No tasks',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ):ListView.builder(
          padding:  EdgeInsets.all(16),
            itemCount: task.length,

            itemBuilder:(context,index) {
      final tasks = task[index];
      return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 10,
      child: ListTile(
      leading: CircleAvatar(
      backgroundColor: Colors.blueAccent,
      child: Text(
      tasks.title.isNotEmpty ? tasks.title[0].toUpperCase() : '',
      style: const TextStyle(color: Colors.white),
                   ),
               ),
            title: Text(
            tasks.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
         ),
         subtitle: Text('${tasks.date} • ${tasks.time}'),
      trailing: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
      color: tasks.state == 'new' ? Colors.orangeAccent : Colors.green,
      borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
      tasks.state.toUpperCase(),
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
      ),
      ),
      );
      },
      ),

      floatingActionButton: FloatingActionButton(
      onPressed: showAddTaskSheet,
      backgroundColor: Colors.blueAccent,
      child: const Icon(Icons.add),
      ),









        
        




      );
    }
  }
