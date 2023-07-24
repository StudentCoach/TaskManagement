
part of 'task_management_bloc.dart';

abstract class TaskManagementEvent {
   const TaskManagementEvent();

  List<Object?> get props => [];
}

class FetchTaskListEvent extends TaskManagementEvent{
  const FetchTaskListEvent();
}

class AddTaskEvent extends TaskManagementEvent{
  const AddTaskEvent();
}

class EditTaskEvent extends TaskManagementEvent{
  const EditTaskEvent();
}

class DeleteTaskEvent extends TaskManagementEvent{
  const DeleteTaskEvent();
}

class OnSegmentChange extends TaskManagementEvent{
  const OnSegmentChange();
}

