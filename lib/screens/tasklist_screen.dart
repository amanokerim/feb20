import 'package:feb20/data/models/task.dart';
import 'package:feb20/logic/cubit/tasklist_cubit.dart';
import 'package:feb20/logic/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/add_task.dart';
import 'widgets/edit_task.dart';

const STATUS = ["В процесе", "Завершен"];

class TasklistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Список задач"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _buildAddSheet(context),
          )
        ],
      ),
      body: BlocBuilder<TasklistCubit, TasklistState>(
        builder: (context, state) {
          if (state is TasklistShow)
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                Task task = state.tasks[index];
                String time = MyTime().toDdMmYyyy(DateTime.parse(task.time));
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    title: Text(task.title),
                    subtitle:
                        Text("Срок: $time\nСтатус: ${STATUS[task.status]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _buildEditSheet(context, task),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          return Container();
        },
      ),
    );
  }

  Future _buildAddSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => AddTask(),
    );
  }

  Future _buildEditSheet(BuildContext context, Task task) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => EditTask(task),
    );
  }
}
