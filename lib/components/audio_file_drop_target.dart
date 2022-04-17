import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import 'drop_target_area.dart';
import 'metadata_data_table.dart';

class AudioFileDropTarget extends StatefulWidget {
  const AudioFileDropTarget({Key? key}) : super(key: key);

  @override
  State<AudioFileDropTarget> createState() => _AudioFileDropTargetState();
}

class _AudioFileDropTargetState extends State<AudioFileDropTarget> {
  XFile? xFile;
  bool _dragging = false;
  Offset? offset;
  Widget? metadataDataTable;

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
          DropTargetArea(dragging: _dragging),
          metadataDataTable ?? const Text(""),
        ],
      ),
    );
  }

  showMetadata(Metadata metadata) {
    setState(() {
      metadataDataTable = MetadataDataTable(xFile: xFile, metadata: metadata);
    });
  }

  showErrorMessage() {
    setState(() {
      metadataDataTable = const Text("error");
    });
  }
}
