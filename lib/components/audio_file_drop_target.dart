import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/track_provider.dart';
import 'drop_target_area.dart';

class AudioFileDropTarget extends StatefulWidget {
  const AudioFileDropTarget({Key? key}) : super(key: key);

  @override
  State<AudioFileDropTarget> createState() => _AudioFileDropTargetState();
}

class _AudioFileDropTargetState extends State<AudioFileDropTarget> {
  XFile? xFile;
  bool _dragging = false;
  Offset? offset;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => DropTarget(
        onDragDone: (detail) async {
          setState(() {
            xFile = detail.files.first;
          });
          MetadataRetriever.fromFile(File(xFile!.path))
              .then((metadata) => ref.read(trackProvider.notifier).update(
                    artist: getArtist(metadata),
                    title: getTitle(metadata),
                  ))
              .catchError((onError) => ref.read(trackProvider.notifier).update(
                    artist: "",
                    title: "",
                  ));
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
          ],
        ),
      ),
    );
  }

  String getArtist(Metadata metadata) {
    return metadata.trackArtistNames != null
        ? metadata.trackArtistNames!.join(", ")
        : "";
  }

  String getTitle(Metadata metadata) {
    if (metadata.trackName != null) {
      return metadata.trackName!;
    } else if (metadata.filePath != null) {
      var reg = RegExp(r"[^/]+(?=\.)");
      String? fileName = reg.allMatches(metadata.filePath!).last.group(0);
      return fileName ?? "";
    } else {
      return "";
    }
  }
}
