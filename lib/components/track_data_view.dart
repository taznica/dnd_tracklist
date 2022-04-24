import 'package:dnd_tracklist/providers/gsheets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/track_provider.dart';
import 'add_button.dart';
import 'metadata_data_table.dart';
import 'tracklist_url_text_field.dart';

class TrackDataView extends StatelessWidget {
  const TrackDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final _sheetController = TextEditingController();
      final _artistController =
          TextEditingController(text: ref.watch(trackProvider).artist);
      final _titleController =
          TextEditingController(text: ref.watch(trackProvider).title);

      Map<String, String> getIdFromSheetURL({required String url}) {
        final parsedURL = Uri.parse(url);
        String spreadsheetId = parsedURL.pathSegments[2];
        String sheetId =
            RegExp(r"([0-9]+)").allMatches(parsedURL.fragment).first.group(0)!;

        return {"spreadsheetId": spreadsheetId, "sheetId": sheetId};
      }

      Future<void> appendTrackInSheet() async {
        final gsheets = await ref.watch(gsheetsProvider.future);
        final ids = getIdFromSheetURL(url: _sheetController.text);

        final spreadsheetId = ids["spreadsheetId"]!;
        final sheets = await gsheets.spreadsheet(spreadsheetId);

        final sheetId = int.parse(ids["sheetId"]!);
        final sheet = sheets.worksheetById(sheetId)!;

        final headerRow = ["Artist", "Title"];
        await sheet.values.insertRow(1, headerRow);

        final row = {
          "Artist": ref.watch(trackProvider).artist,
          "Title": ref.watch(trackProvider).title,
        };
        await sheet.values.map.appendRow(row);
      }

      Future<void> onPressedAdd() async {
        ref.read(trackProvider.notifier).update(
              artist: _artistController.text,
              title: _titleController.text,
            );

        await appendTrackInSheet();
      }

      return Column(
        children: [
          MetadataDataTable(
            artistController: _artistController,
            titleController: _titleController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TracklistURLTextField(controller: _sheetController),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: AddButton(onPressed: onPressedAdd),
          ),
        ],
      );
    });
  }
}
