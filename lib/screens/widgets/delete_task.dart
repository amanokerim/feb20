import 'package:feb20/logic/cubit/tasklist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteTask extends StatelessWidget {
  final int id;
  DeleteTask(this.id);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Удалить?"),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Нет"),
        ),
        FlatButton(
          onPressed: () {
            BlocProvider.of<TasklistCubit>(context).delete(id);
            Navigator.of(context).pop();
          },
          child: Text("Да"),
        ),
      ],
    );
  }
}
