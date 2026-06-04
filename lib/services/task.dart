import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kinza_backend/models/task.dart';

class TaskService{
  String taskCollection = "TaskCollection";
  ///Create Task
  Future createTask(TaskModel model)async{
    DocumentReference documentReference =
    await FirebaseFirestore.instance
    .collection(taskCollection)
    .doc();
    await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
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
  Future deleteTask(String taskID)async{
    await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .delete();
  }
  ///Mark As Completed
  Future markAsCompletedTask(String taskID, bool isCompleted)async{
    await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .update({"isCompleted": isCompleted});
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
  ///Get Saved Task
  Stream<List<TaskModel>> getSavedTask(String userID){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("saved", arrayContains: userID)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())
    ).toList());
  }
  ///Add To Saved
  Future addToSaved({required String taskID, required String userID})
  async {
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .update({"saved": FieldValue.arrayUnion([userID])});
  }
  ///Remove From Saved
  Future removeFromSaved({required String taskID, required String userID})
  async {
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .update({"saved": FieldValue.arrayRemove([userID])});
  }
  ///Get Task By Priority ID
  Stream<List<TaskModel>> getTaskByPriorityID(String priorityID) {
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where('priorityID', isEqualTo: priorityID)
        .snapshots()
        .map(
          (taskList) => taskList.docs
          .map((taskJson) => TaskModel.fromJson(taskJson.data()))
          .toList(),
    );
  }

}