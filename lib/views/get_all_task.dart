import 'package:flutter/material.dart';
import 'package:kinza_backend/models/task.dart';
import 'package:kinza_backend/services/task.dart';
import 'package:kinza_backend/views/create_task.dart';
import 'package:kinza_backend/views/get_completed_task.dart';
import 'package:kinza_backend/views/priority_task/get_all_priority.dart';
import 'package:kinza_backend/views/saved_task.dart';
import 'package:kinza_backend/views/update_task.dart';
import 'package:provider/provider.dart';

import 'get_inCompleted_task.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetInCompletedTask()));
          }, icon: Icon(Icons.incomplete_circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCompletedTask()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetSavedTask()));
          }, icon: Icon(Icons.book)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllPriority()));
          }, icon: Icon(Icons.priority_high)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
          value: TaskService().getAllTask(),
          initialData: [TaskModel()],
          builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[index].title.toString()),
                subtitle: Text(taskList[index].description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()async{
                      if(taskList[index].saved!.contains("1")){
                        await TaskService().removeFromSaved(
                            taskID: taskList[index].docId.toString(),
                            userID: "1");
                      }
                      else{
                        await TaskService().addToSaved(
                            taskID: taskList[index].docId.toString(),
                            userID: "1");
                      }
                    }, icon: Icon(taskList[index].saved!.contains("1") ? Icons.bookmark : Icons.bookmark_border , color: Colors.yellow,)),
                    Checkbox(
                        value: taskList[index].isCompleted,
                        onChanged: (value)async{
                          try{
                            await TaskService().markAsCompletedTask(
                                taskList[index].docId.toString(),
                                value!)
                                .then((value){
                              showDialog(context: context, builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Task Mark As Completed"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Okay"))
                                  ],
                                );
                              });
                            });
                          }catch(e){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        }),
                    IconButton(onPressed: ()async{
                      try{
                        await TaskService().deleteTask(taskList[index].docId.toString())
                            .then((value){
                              showDialog(context: context, builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Task Deleted Successfully"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Okay"))
                                  ],
                                );
                              });
                        });
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(model: taskList[index],)));
                    }, icon: Icon(Icons.edit,color: Colors.blue,))
                  ],
                ),
              );
            },);
          },

      ),
    );
  }
}
