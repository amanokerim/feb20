import 'package:feb20/data/services/database.dart';
import 'package:flutter/material.dart';

class TasklistScreen extends StatefulWidget {
  @override
  _TasklistScreenState createState() => _TasklistScreenState();
}

class _TasklistScreenState extends State<TasklistScreen> {
  @override
  void initState() {
    super.initState();

    _db();
  }

  _db() async {
    print(await Dtbase.instance.delete(1));
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
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
