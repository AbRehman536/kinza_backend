import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kinza_backend/models/user.dart';

class UserService{
  String userCollection = "UserCollection";
  ///Create User
  Future createUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }
  ///Update User
  Future updateUser(UserModel model)async{
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .update({
      "name" : model.name,
      "phone" : model.phone,
      "address" : model.address,
    });
  }
  ///Delete User
  Future deleteUser(String userID)async{
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .delete();
  }
  ///Get User By ID
  Future<UserModel> getUserByID(String userID)async{
    return FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .get()
        .then((user)=> UserModel.fromJson(user.data()!));
  }
}