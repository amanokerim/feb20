import 'package:feb20/data/models/task.dart';
import 'package:feb20/logic/cubit/tasklist_cubit.dart';
import 'package:feb20/logic/time.dart';
import 'package:feb20/screens/widgets/delete_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/add_task.dart';
import 'widgets/edit_task.dart';

const STATUS = ["В процесе", "Завершен"];

class TasklistScreen extends StatefulWidget {
  @override
  _TasklistScreenState createState() => _TasklistScreenState();
}

class _TasklistScreenState extends State<TasklistScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      int status;
      if (_tabController.index == 1) status = 0;
      if (_tabController.index == 2) status = 1;

      BlocProvider.of<TasklistCubit>(context).getTasks(status: status);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                String time = task.time == null
                    ? MyTime().toDdMmYyyy(DateTime.parse(task.time))
                    : "";
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
                          onPressed: () => _buildDeleteDialog(context, task),
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
      bottomNavigationBar: TabBar(
        controller: _tabController,
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
        tabs: [
          Tab(child: Text("Все")),
          Tab(child: Text("В процесе")),
          Tab(child: Text("Выполнено")),
        ],
      ),
    );
  }

  Future _buildDeleteDialog(BuildContext context, Task task) {
    return showDialog(
      context: context,
      builder: (context) => DeleteTask(task.id),
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
