import 'package:flutter/cupertino.dart';
import 'package:kinza_backend/models/task.dart';
import 'package:kinza_backend/models/user.dart';

class UserProvider extends ChangeNotifier{
  UserModel _user = UserModel();

  ///set User
  void setUser(UserModel model){
    _user = model;
    notifyListeners();
  }

  ///get User
  UserModel getUser() => _user;
}