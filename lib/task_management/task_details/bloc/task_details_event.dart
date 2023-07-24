
part of 'task_details_bloc.dart';

abstract class TaskDetailsEvent {
  const TaskDetailsEvent();

  List<Object?> get props => [];
}


class OnDeleteTask extends TaskDetailsEvent{
  const OnDeleteTask();
}

