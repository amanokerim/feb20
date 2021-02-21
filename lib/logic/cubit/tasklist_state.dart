part of 'tasklist_cubit.dart';

abstract class TasklistState extends Equatable {
  const TasklistState();

  @override
  List<Object> get props => [];
}

class TasklistInitial extends TasklistState {}

class TasklistShow extends TasklistState {
  final List<Task> tasks;
  TasklistShow(this.tasks);
}
