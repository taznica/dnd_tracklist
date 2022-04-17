import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import 'components/AddButton.dart';
import 'components/AudioFileDropTarget.dart';
import 'components/tracklistURLTextField.dart';
import 'constants/colors.dart';

void main() {
  // runApp()の前に処理を記述するために必要
  // macOS等のプラットフォームの設定に必要なFlutter Engineは、
  // runApp()内の以下で初めて呼び出される
  // その前にFlutter Engineの機能を利用する際には以下を呼ぶ必要がある
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    setWindowMinSize(const Size(200, 900));
    setWindowMaxSize(const Size(400, 1200));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: textColor,
              displayColor: textColor,
            ),
      ),
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  AudioFileDropTarget(),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: tracklistURLTextField(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(32.0),
                    child: AddButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
