import 'package:feb20/data/models/task.dart';
import 'package:feb20/logic/cubit/tasklist_cubit.dart';
import 'package:feb20/screens/widgets/new_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasklistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TasklistCubit cubit = BlocProvider.of<TasklistCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Список задач"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => AddTask(),
            ),
          )
        ],
      ),
      body: BlocBuilder<TasklistCubit, TasklistState>(
        builder: (context, state) {
          print(state);
          if (state is TasklistShow)
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                Task task = state.tasks[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    title: Text(task.title),
                    subtitle:
                        Text("Срок: ${task.time}       Статус: В процесе"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
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
}
