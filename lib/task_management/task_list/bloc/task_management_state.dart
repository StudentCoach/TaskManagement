part of 'task_management_bloc.dart';

abstract class TaskManagementState {

  const TaskManagementState();

  List<Object?> get props => [];

}

class TaskManagementInitialState extends TaskManagementState{

}

class TaskManagementLoadingState extends TaskManagementState{

  const TaskManagementLoadingState();

}

class TaskManagementLoadedState extends TaskManagementState{

  const TaskManagementLoadedState();

}

class TaskManagementLoadingErrorState extends TaskManagementState{

  const TaskManagementLoadingErrorState();

}