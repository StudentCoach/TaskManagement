import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/common/device_info.dart';

import '../../task_list/data/models/task_response.dart';
import '../../task_list/data/repository/task_management_repository.dart';
part 'task_details_event.dart';
part 'task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {

  final TaskResponse task;

  TaskDetailsBloc({required TaskManagementRepository taskManagementRepository, required this.task}) : super(TaskDetailsInitialState()){

    on<OnDeleteTask>((event, emit) async{

      try{

        var result = await taskManagementRepository.deleteTask(task?.task_id ?? '');

        if (result == 'success'){
          emit(TaskDetailsDeletedState());
        }

      }catch (err){

      }
    });
  }
}