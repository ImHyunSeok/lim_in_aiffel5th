import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:camera/camera.dart';
//import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
//import 'package:image_picker/image_picker.dart';

/* translation */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Translate App'),
    ); // MaterialApp
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  final _sourceLanguage = TranslateLanguage.english;
  final _targetLanguage = TranslateLanguage.korean;
  late final _onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: _sourceLanguage, targetLanguage: _targetLanguage);
  final _tranlationController = StreamController<String>();

  @override
  void dispose() {
    _tranlationController.close();
    _onDeviceTranslator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 45.0,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: '번역할 내용을 입력하세요',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (text) async {
                    final translation =
                        await _onDeviceTranslator.translateText(text);
                    _tranlationController.add(translation);
                  },
                ),
              )),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            padding: const EdgeInsets.only(left: 30),
            child: StreamBuilder<String>(
              stream: _tranlationController.stream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? '',
                  style: const TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}