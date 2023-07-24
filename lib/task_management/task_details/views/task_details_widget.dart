import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/task_management/task_details/bloc/task_details_bloc.dart';
import '../../add_task/views/add_task_screen.dart';
import '../../task_list/data/models/task_response.dart';

class TaskDetailsWidget extends StatelessWidget {
  const TaskDetailsWidget({Key? key, required this.task, required this.onDeleteSuccess,required this.onEditSuccess}) : super(key: key);
  final TaskResponse task;
  final VoidCallback onDeleteSuccess;
  final VoidCallback onEditSuccess;

  @override
  Widget build(BuildContext context) {

    return BlocListener<TaskDetailsBloc, TaskDetailsState>(
      listener: (context, state) {

        if (state is TaskDetailsDeletedState){

          onDeleteSuccess();

          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task deleted Successfully')),
          );

        }
      },
      child: BlocBuilder<TaskDetailsBloc, TaskDetailsState>(builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index){
                if (index == 0){
                  return _TaskDetailsItemView(title: 'Title', value: task.title ?? '',);
                }else if (index == 1){
                  return _TaskDetailsItemView(title: 'Description', value: task.description ?? '',);
                }else if (index == 2){
                  return _TaskDetailsItemView(title: 'Date', value: task.dateString ?? '',);
                }else{
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTaskScreen(
                          onAddSuccess: (){

                          },
                          onEditSuccess: () {
                            onEditSuccess();
                            Navigator.of(context).pop();
                          },
                          currentState: TaskState.edit,
                          task: task,
                        )));
                      }, child: Text('Edit Task')),
                      ElevatedButton(onPressed: (){
                        context.read<TaskDetailsBloc>().add(OnDeleteTask());
                      }, child: Text('Delete'), style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
                    ],
                  );
                }
              }
          ),
        );
      }),
    );


  }
}


///
class _TaskDetailsItemView extends StatelessWidget {
  const _TaskDetailsItemView({Key? key, required this.title, required this.value}) : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
        ],
      ),
    );
  }
}
