import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/priority.dart';

class PriorityTaskServices{
  String priorityCollection = "PriorityCollection";
  ///Create Priority
  Future createPriority(PriorityTaskModel model)async{
    DocumentReference documentReference =
    await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc();
    await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }
  ///Update Priority
  Future updatePriority(PriorityTaskModel model)async{
    await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(model.docId)
        .update({
      "label" : model.label,});
  }
  ///Delete Priority
  Future deletePriority(String priorityID)async{
    await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(priorityID)
        .delete();
  }
  ///Get All Priority
  Stream<List<PriorityTaskModel>> getAllPriority() {
    return FirebaseFirestore.instance
        .collection(priorityCollection)
        .snapshots()
        .map(
          (PriorityList) => PriorityList.docs
          .map((PriorityJson) => PriorityTaskModel.fromJson(PriorityJson.data()))
          .toList(),
    );
  }
  ///Get Priority
  Future<List<PriorityTaskModel>> getPriority() {
    return FirebaseFirestore.instance
        .collection(priorityCollection)
        .get()
        .then(
          (PriorityList) => PriorityList.docs
          .map((PriorityJson) => PriorityTaskModel.fromJson(PriorityJson.data()))
          .toList(),
    );
  }

}