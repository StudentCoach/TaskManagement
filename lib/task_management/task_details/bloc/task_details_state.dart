part of 'task_details_bloc.dart';

abstract class TaskDetailsState {

  const TaskDetailsState();

  List<Object?> get props => [];

}

class TaskDetailsInitialState extends TaskDetailsState{

}

class TaskDetailsDeletingState extends TaskDetailsState{

  const TaskDetailsDeletingState();

}

class TaskDetailsDeletedState extends TaskDetailsState{

  const TaskDetailsDeletedState();

}

class TaskDetailsDeleteErrorState extends TaskDetailsState{

  const TaskDetailsDeleteErrorState();

}