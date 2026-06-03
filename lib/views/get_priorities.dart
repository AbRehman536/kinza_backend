import 'package:flutter/material.dart';
import 'package:kinza_backend/models/priority.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../services/task.dart';

class GetPriorityTask extends StatelessWidget {
  final PriorityTaskModel model;
  const GetPriorityTask({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.label} Priority Task"),
      ),
      body: StreamProvider.value(
        value: TaskService().getTaskByPriorityID(model.docId.toString()),
        initialData: [TaskModel()],
        builder: (context, child){
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.task_alt),
              title: Text(taskList[index].title.toString()),
              subtitle: Text(taskList[index].description.toString()),
              trailing: Icon(Icons.add),
            );
          },);
        },
      ),
    );
  }
}