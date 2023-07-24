part of 'add_task_bloc.dart';

abstract class AddTaskState {

  const AddTaskState();

  List<Object?> get props => [];

}

class AddTaskInitialState extends AddTaskState{

}

class AddTaskLoadingState extends AddTaskState{

  const AddTaskLoadingState();

}

class AddTaskSuccessState extends AddTaskState{

  const AddTaskSuccessState();

}

class AddTaskLoadingErrorState extends AddTaskState{

  const AddTaskLoadingErrorState();

}