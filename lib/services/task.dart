import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kinza_backend/models/task.dart';

class TaskService{
  String taskCollection = "TaskCollection";
  ///Create Task
  Future createTask(TaskModel model)async{
    await FirebaseFirestore.instance
        .collection(taskCollection)
        .add(model.toJson());
  }
  ///Update Task
  Future updateTask(TaskModel model)async{
    await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({
      "title" : model.title,
      "description" : model.description,});
  }
  ///Delete Task
  Future deleteTask(TaskModel model)async{
    await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .delete();
  }
  ///Mark As Completed
  Future markAsCompletedTask(TaskModel model)async{
    await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({"isCompleted": model.isCompleted});
  }
  ///Get All Task
  Stream<List<TaskModel>> getAllTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())
    ).toList());
  }
  ///Get InCompleted Task
  Stream<List<TaskModel>> getInCompletedTask(){
    return FirebaseFirestore.instance //connection with firebase
        .collection(taskCollection) //name of table/collection
        .where("isCompleted", isEqualTo: false) // query to show specific data
        .snapshots() // get updated data
        .map((taskList) => taskList.docs //copy all doc data and store in tasklist
        .map((taskJson) => TaskModel.fromJson(taskJson.data()) // convert json data into model objects
    ).toList());
  }
  ///Get Completed Task
  Stream<List<TaskModel>> getCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("isCompleted", isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())
    ).toList());
  }
}