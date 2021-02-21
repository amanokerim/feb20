import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feb20/data/models/task.dart';
import 'package:feb20/data/services/dtbase.dart';

part 'tasklist_state.dart';

class TasklistCubit extends Cubit<TasklistState> {
  TasklistCubit() : super(TasklistInitial());

  List<Task> tasks;

  getTasks() async {
    List<Map<String, dynamic>> tasksMap = await Dtbase.instance.getTasks();
    tasks = tasksMap.map((map) => Task.fromMap(map)).toList();
    emit(TasklistShow(tasks));
    print(tasks.length);
  }

  add(Task task) async {
    await Dtbase.instance.insert(task);
    getTasks();
    emit(TasklistShow(tasks));
  }
}
