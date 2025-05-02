

class TaskModel{
  int? id;
  String title;
  String date;
  String time;
  String state;

  TaskModel({
    this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.state,

});

  Map<String,dynamic>toMap(){
    return{

      'id':id,
      'title':title,
      'date':date,
      'time':time,
      'state':state,

    };
  }

  factory TaskModel.fromMap(Map<String,dynamic>map){


    return TaskModel(
        id: map['id'],title: map['title'], date: map['date'], time: map['time'], state: map['state']);

  }






}