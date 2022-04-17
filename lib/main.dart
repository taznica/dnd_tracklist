import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:window_size/window_size.dart';

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
        scaffoldBackgroundColor: const Color(0xff2b303b),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: const Color(0xffa7adb9),
              displayColor: const Color(0xffa7adb9),
            ),
      ),
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AudioFileDropTarget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xff434954),
                          ),
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xff434954),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        hintText: " Tracklist URL (Google Sheets)",
                        hintStyle: const TextStyle(
                          color: Color(0xff434954),
                          fontSize: 14.0,
                        ),
                      ),
                      cursorColor: const Color(0xff434954),
                      cursorWidth: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: SizedBox(
                      width: 80,
                      height: 40,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xffffffff)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff55afa6)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                        child: const Text("Add"),
                      ),
                    ),
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

class AudioFileDropTarget extends StatefulWidget {
  const AudioFileDropTarget({Key? key}) : super(key: key);

  @override
  State<AudioFileDropTarget> createState() => _AudioFileDropTargetState();
}

class _AudioFileDropTargetState extends State<AudioFileDropTarget> {
  XFile? xFile;
  bool _dragging = false;
  Offset? offset;
  Widget? metadataTable;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) async {
        setState(() {
          xFile = detail.files.first;
        });
        MetadataRetriever.fromFile(File(xFile!.path))
          ..then((metadata) => showMetadata(metadata))
          ..catchError((onError) => showErrorMessage());
      },
      onDragUpdated: (details) {
        setState(() {
          offset = details.localPosition;
        });
      },
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
          offset = detail.localPosition;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
          offset = null;
        });
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
                color: _dragging
                    ? const Color(0xff111318)
                    : const Color(0xff1a1d23),
              ),
              child: Stack(
                children: const [
                  Center(
                    child: Text(
                      "Drop here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          metadataTable ?? const Text(""),
        ],
      ),
    );
  }

  showMetadata(Metadata metadata) {
    setState(() {
      metadataTable = DataTable(
        headingRowHeight: 0,
        dataRowHeight: 100,
        columns: [
          DataColumn(label: Container()),
          DataColumn(label: Container()),
        ],
        rows: [
          DataRow(
            cells: [
              const DataCell(Text(
                "Artist",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataCell(Text(
                metadata.trackArtistNames != null
                    ? metadata.trackArtistNames!.join(", ")
                    : "null",
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataCell(Text(
                metadata.trackName ?? "null",
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text(
                "File name",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataCell(Text(
                xFile != null ? xFile!.name : "Drop here",
              )),
            ],
          ),
        ],
      );
    });
  }

  showErrorMessage() {
    setState(() {
      metadataTable = const Text("error");
    });
  }
}
