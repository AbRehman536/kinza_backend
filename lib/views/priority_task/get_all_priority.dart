import 'package:flutter/material.dart';
import 'package:kinza_backend/services/priority.dart';
import 'package:kinza_backend/views/get_priorities.dart';
import 'package:kinza_backend/views/priority_task/create_update_task.dart';
import 'package:provider/provider.dart';

import '../../models/priority.dart';

class GetAllPriority extends StatelessWidget {
  const GetAllPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Priority"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateTask(model: PriorityTaskModel(), isUpdateMode: false,)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: PriorityTaskServices().getAllPriority(),
          initialData: [PriorityTaskModel()],
        builder: (context, child){
            List<PriorityTaskModel> priorityList = context.watch<List<PriorityTaskModel>>();
            return ListView.builder(
              itemCount: priorityList.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.priority_high),
                title: Text(priorityList[index].label.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateTask(model: priorityList[index], isUpdateMode: true,)));
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: ()async{
                      try{
                        await PriorityTaskServices().deletePriority(
                            priorityList[index].docId.toString()
                        );
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetPriorityTask(model: PriorityTaskModel())));
                    }, icon: Icon(Icons.arrow_forward))
                  ],
                ),
              );
            },);
        },

      ),
    );
  }
}
