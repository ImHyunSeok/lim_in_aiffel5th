import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolistproject/app/service/auth_service.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseAuth auth;
  
  void initState(){
    super.initState();
    auth = FirebaseAuth.instance;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, title: const Text('Modu Todo'),
        actions: [IconButton(
          icon: Icon(Icons.logout_rounded), 
          onPressed: () { 
            logOut(context, auth);
           },
        ),
        ],
      ),
    
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add) ),
    body
    );
  }
}