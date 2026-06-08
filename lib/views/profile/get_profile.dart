import 'package:flutter/material.dart';
import 'package:kinza_backend/provider/user.dart';
import 'package:kinza_backend/views/profile/update_profile.dart';
import 'package:provider/provider.dart';
class GetProfile extends StatelessWidget {
  const GetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Icon(Icons.person),
          SizedBox(height: 10,),
          Text("Name: ${userProvider.getUser().name.toString()}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 10,),
          Text("Email: ${userProvider.getUser().email.toString()}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 10,),
          Text("Contact: ${userProvider.getUser().phone.toString()}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 10,),
          Text("Address: ${userProvider.getUser().address.toString()}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 10,),
          ElevatedButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile()));
          }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
