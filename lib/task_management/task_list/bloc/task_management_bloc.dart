import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/common/device_info.dart';
import '../data/models/task_response.dart';
import '../data/repository/task_management_repository.dart';

part 'task_management_event.dart';
part 'task_management_state.dart';

class TaskManagementBloc extends Bloc<TaskManagementEvent, TaskManagementState> {

  List<TaskResponse> todayTaskList = [];
  List<TaskResponse> tomorrowTaskList = [];
  List<TaskResponse> upcomingTaskList = [];


  TaskManagementBloc({required TaskManagementRepository taskManagementRepository}) : super(TaskManagementInitialState()){

    on<FetchTaskListEvent>((event, emit) async{

      try{

        var id = await getDeviceId();

        var results = await taskManagementRepository.getTasks(id ?? '');


        print(results);

        if (results != null){

          todayTaskList = [];
          tomorrowTaskList = [];
          upcomingTaskList = [];

          for (var result in results){

            print(calculateDifference(result.date!));

            if (calculateDifference(result.date!) == 0){
              todayTaskList.add(result);
            }else if (calculateDifference(result.date!) == 1){
              tomorrowTaskList.add(result);
            }else if (calculateDifference(result.date!) > 1){
              upcomingTaskList.add(result);
            }
          }
          emit(TaskManagementLoadedState());
        }
      }catch (err){

      }
    });


    on<OnSegmentChange>((event, emit) async{
      emit(TaskManagementInitialState());
    });


    add(FetchTaskListEvent());
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

}