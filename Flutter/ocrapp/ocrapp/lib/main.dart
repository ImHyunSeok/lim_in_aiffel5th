import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Modulabs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final CameraController _cameraController;
  final _controller = TextEditingController();
  TranslateLanguage _sourceLanguage = TranslateLanguage.english;
  TranslateLanguage _targetLanguage = TranslateLanguage.korean;
  late OnDeviceTranslator _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: _sourceLanguage,
    targetLanguage: _targetLanguage,
  );
  final _translationController = StreamController<String>();
  bool _cameraIsBusy = false;
  bool _recognitionIsBusy = false;

  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  String? _text;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _translationController.close();
    _onDeviceTranslator.close();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<void> captureAndRecognizeText() async {
    if (_recognitionIsBusy) return;
    _recognitionIsBusy = true;

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _recognizeText(InputImage.fromFilePath(image.path));
    }

    _recognitionIsBusy = false;
  }

  Future<void> _recognizeText(InputImage inputImage) async {
    _recognitionIsBusy = true;

    final recognizedText = await _textRecognizer.processImage(inputImage);
    _controller.text = recognizedText.text;

    _recognitionIsBusy = false;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: DropdownButtonFormField<TranslateLanguage>(
                      value: _sourceLanguage,
                      onChanged: (value) {
                        setState(() {
                          _sourceLanguage = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: TranslateLanguage.english,
                          child: Text('영어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.korean,
                          child: Text('한국어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.japanese,
                          child: Text('일본어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.chinese,
                          child: Text('중국어'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: '소스 언어',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButtonFormField<TranslateLanguage>(
                      value: _targetLanguage,
                      onChanged: (value) {
                        setState(() {
                          _targetLanguage = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: TranslateLanguage.english,
                          child: Text('영어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.korean,
                          child: Text('한국어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.japanese,
                          child: Text('일본어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.chinese,
                          child: Text('중국어'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: '타겟 언어',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '번역할 내용을 입력하세요',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) async {
                final translation =
                    await _onDeviceTranslator.translateText(text);
                _translationController.add(translation);
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<String>(
              stream: _translationController.stream,
              builder: (context, snapshot) {
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              captureAndRecognizeText();
            },
            child: Container(
              alignment: Alignment.center,
              height: 75,
              color: Colors.yellow,
              child: const Icon(Icons.search),
            ),
          ),
          InkWell(
            onTap: () {
              // TODO: Add microphone icon button functionality
            },
            child: Container(
              alignment: Alignment.center,
              height: 75,
              color: Colors.orange,
              child: const Icon(Icons.mic),
            ),
          ),
        ],
      ),
    );
  }
}
