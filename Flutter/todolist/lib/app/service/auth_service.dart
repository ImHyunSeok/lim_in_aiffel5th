import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

Future<void> loginWithEmailAndPassword(FirebaseAuth auth, String email, String password) async{
  try {
    UserCredential userCredential = 
      await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
  }
  catch(e){
    print('Login Failed: $e');
  }
}

Future<void> logOut(BuildContext context, FirebaseAuth auth) async {
  try {
    await auth.signOut();
    
  }catch(e){}
  }

Future<void> registerWithEmail(FirebaseAuth auth, String email, String password, String name ) async {
  try {UserCredential userCredential = await auth.createUserWithEmailAndPassword(
    email: email, password: password);
    User? user = userCredential.user;
    if(user == null){
      print('Register Fail');
    } else {
      print('Register Success');
      Navigator.pushReplacementNamed(context, '/login');
    }
    }catch (e) {}
}