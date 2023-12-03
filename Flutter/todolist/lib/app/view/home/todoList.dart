import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget{
  _TodoListState createState() => _TodoListState();
  
}

class _TodoListState extends State<TodoList>{
  late FirebaseFirestore firestore;
  @override
  void initState(){
    super.initState();
    firestore = FirebaseFirestore.instance;
  }
  @override
  Widget build(BuildContext context ){
    return Container(
      margin: const EdgeInsets.all(10),
      child: StreamBuilder<List<Todo>>(),
    );
  }

}
