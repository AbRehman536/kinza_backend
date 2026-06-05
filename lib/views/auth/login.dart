import 'package:flutter/material.dart';
import 'package:kinza_backend/services/auth.dart';
import 'package:kinza_backend/views/auth/register.dart';
import 'package:kinza_backend/views/auth/reset_password.dart';
import 'package:kinza_backend/views/get_all_task.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email"
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
                hintText: "Password"
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  await AuthService().loginUser(
                      email: emailController.text,
                      password: passwordController.text)
                      .then((val){
                        if(val.emailVerified == true){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllTask()));
                        }
                        else{
                          showDialog(
                              context: context, builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("Please verify your email"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Okay"))
                                  ],
                                );
                          }, );
                        }
                  });

                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Login")),

          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
          }, child: Text("Register")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));
          }, child: Text("Reset Password")),

        ],
      )
    );
  }
}
