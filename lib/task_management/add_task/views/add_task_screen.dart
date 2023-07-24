import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/task_management/task_list/data/models/task_response.dart';
import '../../task_list/data/repository/task_management_repository.dart';
import '../bloc/add_task_bloc.dart';
import 'add_task_widget.dart';

enum TaskState {
  edit,
  add
}

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key, required this.onAddSuccess, required this.currentState,this.task, required this.onEditSuccess}) : super(key: key);
  final VoidCallback onAddSuccess;
  final TaskState currentState;
  final TaskResponse? task;
  final VoidCallback onEditSuccess;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context){
        return AddTaskBloc(taskManagementRepository: TaskManagementRepository(), task: task);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text((currentState == TaskState.add) ? 'Add Task' : 'Edit Task'),
        ),
        body: AddTaskWidget(currentState: currentState,onAddSuccess: () {onAddSuccess();}, onEditSuccess: (){onEditSuccess();},),
      ),
    );
  }
}
