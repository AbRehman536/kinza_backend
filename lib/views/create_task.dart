import 'package:flutter/material.dart';
import 'package:kinza_backend/models/priority.dart';
import 'package:kinza_backend/services/priority.dart';
import '../models/task.dart';
import '../services/task.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  List<PriorityTaskModel> priorityList = [];
  PriorityTaskModel? _selectedPriority;
  @override
  void initState(){
    PriorityTaskServices().getPriorities().then((value){
      priorityList = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        TextField(controller: descriptionController,),
        DropdownButton(
            hint:  Text("Select Priority"),
            value: _selectedPriority,
            items: priorityList.map((e){
              return DropdownMenuItem(
                  value: e,
                  child: Text(e.label.toString()));
            }).toList(),
            onChanged: (value){
              setState(() {
                _selectedPriority = value;
              });
            }),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            setState(() {});
            await TaskService().createTask(TaskModel(
                title: nameController.text.toString(),
                description: descriptionController.text.toString(),
                isCompleted: false,
                createdAt: DateTime.now().millisecondsSinceEpoch
            )).then((value){
              isLoading = false;
              setState(() {});
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Create Successfully"),
                    actions: [
                      TextButton(onPressed: (){}, child: Text("Okay"))
                    ],
                  );
                }, );
            });
          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Create Task"))
      ],),
    );
  }
}