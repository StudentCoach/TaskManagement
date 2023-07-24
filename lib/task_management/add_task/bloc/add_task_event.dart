
part of 'add_task_bloc.dart';

abstract class AddTaskEvent {
  const AddTaskEvent();

  List<Object?> get props => [];
}


class OnAddTask extends AddTaskEvent{
  const OnAddTask();
}

class EditTaskEvent extends AddTaskEvent{
  const EditTaskEvent();
}

class OnChange extends AddTaskEvent{
  const OnChange();
}