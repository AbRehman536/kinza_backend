import 'package:flutter/material.dart';
import 'package:kinza_backend/models/user.dart';
import 'package:kinza_backend/services/auth.dart';
import 'package:kinza_backend/services/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          TextField(
            controller: cpasswordController,
            decoration: InputDecoration(
              hintText: "Confirm Password",
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
                  await AuthService().registerUser(
                      email: emailController.text,
                      password: passwordController.text)
                  .then((val)async{
                    await UserService().createUser(
                      UserModel(
                        docId: val.uid,
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        createdAt: DateTime.now().millisecondsSinceEpoch
                      )
                    ).then((value){
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Register Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],
                        );
                      });
                    });
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
