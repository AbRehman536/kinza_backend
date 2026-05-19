import 'package:flutter/material.dart';
import 'package:kinza_backend/models/task.dart';
import 'package:kinza_backend/services/task.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Title",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10,),

          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: "Description",
              border: OutlineInputBorder(),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  await TaskService().createTask(
                    TaskModel(
                      title: titleController.text.toString(),
                      description: descriptionController.text.toString(),
                      isCompleted: false,
                      createdAt: DateTime.now().millisecondsSinceEpoch,
                    )
                  ).then((value){
                    isLoading = false;
                    setState(() {});
                    showDialog(
                        context: context,
                      builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Create Successfully"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }, child: Text("Okay"))
                            ],
                          );
                      },);
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Create Task"))
        ],
      ),
    );
  }
}
