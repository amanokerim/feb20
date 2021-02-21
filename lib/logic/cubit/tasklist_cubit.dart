import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feb20/data/models/task.dart';
import 'package:feb20/data/services/dtbase.dart';

part 'tasklist_state.dart';

class TasklistCubit extends Cubit<TasklistState> {
  TasklistCubit() : super(TasklistInitial());

  List<Task> tasks;

  getTasks({int status}) async {
    List<Map<String, dynamic>> tasksMap =
        await Dtbase.instance.getTasks(status: status);
    tasks = tasksMap.map((map) => Task.fromMap(map)).toList();
    emit(TasklistShow(tasks));
  }

  add(Task task) async {
    await Dtbase.instance.insert(task);
    getTasks();
  }

  edit(Task task) async {
    await Dtbase.instance.edit(task);
    getTasks();
  }

  delete(int id) async {
    await Dtbase.instance.delete(id);
    getTasks();
  }
}
