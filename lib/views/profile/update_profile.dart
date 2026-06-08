import 'package:flutter/material.dart';
import 'package:kinza_backend/models/user.dart';
import 'package:kinza_backend/services/user.dart';
import 'package:provider/provider.dart';

import '../../provider/user.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    var userProvider = Provider.of<UserProvider>(context);
    super.initState();
    nameController = TextEditingController(
      text: userProvider.getUser().name.toString(),
    );
    phoneController = TextEditingController(
      text: userProvider.getUser().phone.toString(),
    );
    addressController = TextEditingController(
      text: userProvider.getUser().address.toString(),
    );
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Name",
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              hintText: "Phone",
            ),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hintText: "Address",
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  await UserService().updateUser(
                    UserModel(
                      docId: userProvider.getUser().docId.toString(),
                      name: nameController.text,
                      phone: phoneController.text,
                      address: addressController.text,
                      createdAt: DateTime.now().millisecondsSinceEpoch
                    )
                  ).then((value){
                    isLoading = false;
                    setState(() {});
                    showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("Profile Update Successfully"),
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
          }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
