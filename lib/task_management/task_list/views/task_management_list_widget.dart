import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/task_management/task_details/views/task_details_screen.dart';
import '../../add_task/views/add_task_screen.dart';
import '../bloc/task_management_bloc.dart';
import '../data/models/task_response.dart';

class TaskManagementListWidget extends StatelessWidget {

  TaskManagementListWidget({Key? key}) : super(key: key);

  static const titles = ['Today', 'Tomorrow', 'Upcoming'];
  int groupValue = 0;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TaskManagementBloc, TaskManagementState>(
        builder: (context, state){

          return Scaffold(
              appBar: AppBar(
                title: const Text('Task Management'),
              ),
              body: Column(
                children: [
                  CupertinoSegmentedControl<int>(
                    padding: EdgeInsets.all(8),
                    groupValue: groupValue,
                    onValueChanged: (int? value) {
                      groupValue = value ?? 0;
                      context.read<TaskManagementBloc>().add(const OnSegmentChange());
                    },
                    children: {
                      0: buildSegment("Today", 0),
                      1: buildSegment("Tomorrow", 1),
                      2: buildSegment("Upcoming", 2),
                    },

                  ),

                  if (getTasks(context, groupValue).isNotEmpty)
                    _TaskListItemView(
                      tasks: getTasks(context, groupValue),
                      title: titles[groupValue],
                    ),
                  if (getTasks(context, groupValue).isEmpty)
                    const Expanded(child: Center(child: Text('No Task Found', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))),

                ],
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AddTaskScreen(
                    onAddSuccess: () {
                      context.read<TaskManagementBloc>().add(const FetchTaskListEvent());
                    },
                    onEditSuccess: () {
                      context.read<TaskManagementBloc>().add(const FetchTaskListEvent());
                    },
                    currentState: TaskState.add,
                  )));
                },
                tooltip: 'add',
                child: const Icon(Icons.add),
              )

          );
        }
    );
  }

  Widget buildSegment(String text, int index){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(text,style: TextStyle(fontSize: 18,
          color: groupValue == index ? Colors.white : Colors.black),),
    );
  }

  List<TaskResponse> getTasks(BuildContext context,int index) {
    if (index == 0){
      return context.read<TaskManagementBloc>().todayTaskList;
    }else if (index == 1){
      return context.read<TaskManagementBloc>().tomorrowTaskList;
    }else{
      return context.read<TaskManagementBloc>().upcomingTaskList;
    }
  }
}

class _TaskListItemView extends StatelessWidget {
  const _TaskListItemView({Key? key, required this.title,  required this.tasks}) : super(key: key);

  final String title;
  final List<TaskResponse> tasks;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => TaskDetailsScreen(
                        task:tasks[index],
                      onDeleteSuccess: (){
                        context.read<TaskManagementBloc>().add(const FetchTaskListEvent());
                      },
                      onEditSuccess: (){
                        context.read<TaskManagementBloc>().add(const FetchTaskListEvent());
                      },
                    )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                            borderRadius: BorderRadius.circular(25.0)
                          ),
                            child: Center(child: const Icon(Icons.task, size: 25,))
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(tasks[index].title ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}