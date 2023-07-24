import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/task_management/task_details/bloc/task_details_bloc.dart';
import 'package:task_management_app/task_management/task_details/views/task_details_widget.dart';
import 'package:task_management_app/task_management/task_list/data/models/task_response.dart';
import '../../task_list/data/repository/task_management_repository.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({Key? key, required this.task, required this.onDeleteSuccess, required this.onEditSuccess}) : super(key: key);

  final TaskResponse task;
  final VoidCallback onDeleteSuccess;
  final VoidCallback onEditSuccess;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context){
        return TaskDetailsBloc(taskManagementRepository: TaskManagementRepository(), task: task);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task Details'),
        ),
        body: TaskDetailsWidget(task: task, onDeleteSuccess: () {onDeleteSuccess();}, onEditSuccess: (){
          onEditSuccess();
        },),
      ),
    );

  }
}
