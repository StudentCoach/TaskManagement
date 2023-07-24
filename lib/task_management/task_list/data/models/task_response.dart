
import 'package:intl/intl.dart';

class TaskResponse {

  String? title;
  String? description;
  String? dateString;
  DateTime? date;
  String? task_id;


  TaskResponse({this.title, this.dateString, this.description, this.date, this.task_id});


  TaskResponse.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    dateString = json['date'];
    task_id = json['task_id'];

    print(dateString);

    date = DateFormat("dd-MM-yyyy").parse(dateString ?? "");

  }

}