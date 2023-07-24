import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/task_management/task_list/views/task_management_list_widget.dart';
import '../bloc/task_management_bloc.dart';
import '../data/repository/task_management_repository.dart';

class TaskManagementListScreen extends StatelessWidget {
  const TaskManagementListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return TaskManagementBloc(taskManagementRepository: TaskManagementRepository());
      },
      child:  TaskManagementListWidget()
    );
  }
}


