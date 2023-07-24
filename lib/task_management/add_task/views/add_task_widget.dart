import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/task_management/add_task/bloc/add_task_bloc.dart';
import 'package:intl/intl.dart';

import 'add_task_screen.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget(
      {Key? key, required this.onAddSuccess, required this.currentState, required this.onEditSuccess})
      : super(key: key);
  final VoidCallback onAddSuccess;
  final VoidCallback onEditSuccess;
  final TaskState currentState;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskBloc, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskSuccessState) {

          if (currentState == TaskState.add){
            onAddSuccess();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task Added Successfully')),
            );
          }else{
            onEditSuccess();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task Updated Successfully')),
            );
          }
        }
      },
      child: BlocBuilder<AddTaskBloc, AddTaskState>(builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextField(
                  controller: context.read<AddTaskBloc>().titleController,
                  decoration:
                      const InputDecoration(hintText: '', labelText: 'Task'),
                  onChanged: (text) {
                    context.read<AddTaskBloc>().add(OnChange());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextField(
                  controller: context.read<AddTaskBloc>().descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: '', labelText: 'Description'),
                  onChanged: (text) {
                    context.read<AddTaskBloc>().add(OnChange());
                  },
                ),
              ),
              _DateView(),
              ElevatedButton(
                onPressed: context.read<AddTaskBloc>().isAddTaskValid()
                    ? () {
                        if (currentState == TaskState.add) {
                          context.read<AddTaskBloc>().add(OnAddTask());
                        } else {
                          context.read<AddTaskBloc>().add(EditTaskEvent());
                        }
                      }
                    : null,
                child: Text((currentState == TaskState.add) ? 'Add' : 'Update'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _DateView extends StatefulWidget {
  const _DateView({Key? key}) : super(key: key);

  @override
  State<_DateView> createState() => _DateViewState();
}

class _DateViewState extends State<_DateView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: TextField(
          controller: context.read<AddTaskBloc>().dateController,
          enabled: false,
          decoration: const InputDecoration(hintText: '', labelText: 'Date'),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: context.read<AddTaskBloc>().selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        context.read<AddTaskBloc>().dateController.text =
            DateFormat('dd-MM-yyyy').format(picked);
        context.read<AddTaskBloc>().add(const OnChange());
      });
    }
  }
}
