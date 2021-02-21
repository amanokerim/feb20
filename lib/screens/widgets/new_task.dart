import 'package:feb20/data/models/task.dart';
import 'package:feb20/logic/cubit/tasklist_cubit.dart';
import 'package:feb20/logic/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _titleController;
  DateTime time;
  TasklistCubit cubit;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _theme = Theme.of(context).textTheme;
    cubit = BlocProvider.of<TasklistCubit>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Новая задача",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: "Заголовок:",
              labelStyle: _theme.subtitle1,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                "Срок: ",
                style: _theme.subtitle1,
              ),
              time == null
                  ? FlatButton(
                      onPressed: () => _selectTime(context),
                      child: Text("Выбрать срок"),
                    )
                  : Text(MyTime().toDdMmYyyy(time) + " г."),
            ],
          ),
          SizedBox(height: 10.0),
          Center(
            child: FlatButton(
              onPressed: _addTask,
              child: Text("Добавить", style: _theme.button),
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 30.0)
        ],
      ),
    );
  }

  void _addTask() {
    Task task = Task(
      time: time.toString(),
      title: _titleController.text,
    );
    cubit.add(task);
    Navigator.of(context).pop();
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2100, 1, 1),
    );

    if (picked != null) setState(() => time = picked);
  }
}
