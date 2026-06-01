import 'package:flutter/material.dart';
import 'package:kinza_backend/models/priority.dart';
import 'package:kinza_backend/services/priority.dart';

class CreateUpdateTask extends StatefulWidget {
  final PriorityTaskModel model;
  final bool isUpdateMode;
  const CreateUpdateTask({super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreateUpdateTask> createState() => _CreateUpdateTaskState();
}

class _CreateUpdateTaskState extends State<CreateUpdateTask> {
  TextEditingController labelController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    if(widget.isUpdateMode == true)
    labelController = TextEditingController(
      text: widget.model.label.toString(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode ? "Update Priority" : "Create Priority"),
        backgroundColor: widget.isUpdateMode ? Colors.blue : Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: labelController,
            decoration: InputDecoration(
              hintText: "Label",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  if(widget.isUpdateMode == true){
                    isLoading = true;
                    setState(() {});
                    await PriorityTaskServices().updatePriority(
                      PriorityTaskModel(
                        docId: widget.model.docId.toString(),
                        label: labelController.text.toString(),
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                      )
                    ).then((value){
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Update Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],
                        );

                      },);
                    });
                  }
                  else{
                    isLoading = true;
                    setState(() {});
                    await PriorityTaskServices().createPriority(
                        PriorityTaskModel(
                          label: labelController.text.toString(),
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                        )
                    ).then((value){
                      showDialog(context: context, builder: (BuildContext context) {
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
                  }
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text(
            widget.isUpdateMode ? "Update Priority" : "Create Priority"
          ))
        ],
      )

    );
  }
}
