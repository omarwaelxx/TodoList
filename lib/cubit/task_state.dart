


import 'package:todo_list/model/task_model.dart';

abstract  class TaskState{}

class TaskInitial extends TaskState{}
class TaskLoading extends TaskState{}
class TaskSuccess extends TaskState{
  final List<TaskModel> tasks;
  TaskSuccess( this.tasks);
}


class TaskError extends TaskState{
  final String errorMessage;
  TaskError( this.errorMessage);
}








