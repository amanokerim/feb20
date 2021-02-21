import 'package:feb20/data/models/task.dart';
import 'package:feb20/logic/cubit/tasklist_cubit.dart';
import 'package:feb20/logic/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTask extends StatefulWidget {
  const EditTask(this.task);
  final Task task;

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController _titleController;
  bool isComplete = false;
  TasklistCubit cubit;
  DateTime time;
  Task task;
  String error = "";

  @override
  void initState() {
    super.initState();
    task = widget.task;
    time = DateTime.parse(task.time);
    isComplete = task.status == 1;
    _titleController = TextEditingController(text: task.title);
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
      padding: EdgeInsets.fromLTRB(
        20.0,
        20.0,
        20.0,
        MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Редактировать задачу",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Text(error, style: TextStyle(color: Colors.red)),
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
              FlatButton(
                onPressed: () => _selectTime(context),
                child: Text(
                  time == null
                      ? "Выбрать срок"
                      : MyTime().toDdMmYyyy(time) + " г.",
                ),
              ),
            ],
          ),
          SwitchListTile(
              value: isComplete,
              contentPadding: EdgeInsets.zero,
              title: Text("Выполнено"),
              onChanged: (val) => setState(() => isComplete = val)),
          SizedBox(height: 10.0),
          Center(
            child: FlatButton(
              onPressed: _editTask,
              child: Text("Изменить", style: _theme.button),
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 30.0)
        ],
      ),
    );
  }

  void _editTask() {
    if (time == null || _titleController.text.isEmpty) {
      setState(() => error = "Заполните все поля");
      return;
    }
    Task task = Task(
      id: widget.task.id,
      time: time.toString(),
      title: _titleController.text,
      status: isComplete ? 1 : 0,
    );
    cubit.edit(task);
    Navigator.of(context).pop();
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: time ?? DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2100, 1, 1),
    );

    if (picked != null) setState(() => time = picked);
  }
}
