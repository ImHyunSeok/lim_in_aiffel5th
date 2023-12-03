import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolistproject/app/view/auth/login.dart';
import 'package:todolistproject/app/view/auth/register.dart';
import 'package:todolistproject/app/view/home/home.dart';
import 'package:todolistproject/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  _MyAppState createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp>{ 
  late FirebaseAuth auth;

  @override
  void initState(){
    super.initState();
    auth = FirebaseAuth.instance;
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'to-do list project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      routes: {
        '/login' : (context) => LoginPage(),
        '/register': (context) => RegisterPage()
        },
      home: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.black, 
            );
          }
          else {
            if(snapshot.data == null){
              return HomePage();
            } else {
              return LoginPage();
            } 
          }
        }
      ),
      );
  }
}
  
  
  


 


