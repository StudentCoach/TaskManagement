import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/common/device_info.dart';

import '../../task_list/data/models/task_response.dart';
import '../../task_list/data/repository/task_management_repository.dart';
part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final TaskResponse? task;



  AddTaskBloc({required TaskManagementRepository taskManagementRepository, this.task}) : super(AddTaskInitialState()){

    titleController.text = task?.title ?? '';
    descriptionController.text = task?.description ?? '';
    dateController.text = task?.dateString ?? '';

    on<OnAddTask>((event, emit) async{

      try{

        var id = await getDeviceId();

        var result = await taskManagementRepository.addTask(title: titleController.text.trim(), description: descriptionController.text.trim(), date: dateController.text.trim(), id: id ?? '');

        if (result == 'success'){
          emit(AddTaskSuccessState());
        }

        print(result);

      }catch (err){

      }
    });

    on<EditTaskEvent>((event, emit) async{

      try{

        var id = await getDeviceId();

        var result = await taskManagementRepository.editTask(
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            date: dateController.text.trim(),
            id: id ?? '',
          taskId: task?.task_id ?? ''
        );

        if (result == 'success'){
          emit(AddTaskSuccessState());
        }

        print(result);

      }catch (err){

      }
    });



    on<OnChange>((event, emit) async{
      emit(AddTaskInitialState());
    });

  }


  bool isAddTaskValid() {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty){
      return true;
    }
    return false;
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

}