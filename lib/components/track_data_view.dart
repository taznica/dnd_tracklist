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
      final _artistController =
          TextEditingController(text: ref.watch(trackProvider).artist);
      final _titleController =
          TextEditingController(text: ref.watch(trackProvider).title);

      void onPressedAdd() {
        ref.read(trackProvider.notifier).update(
              artist: _artistController.text,
              title: _titleController.text,
            );

        // TODO: send to sheet
        print(ref.watch(trackProvider).artist);
        print(ref.watch(trackProvider).title);
      }

      return Column(
        children: [
          MetadataDataTable(
            artistController: _artistController,
            titleController: _titleController,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: TracklistURLTextField(),
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
