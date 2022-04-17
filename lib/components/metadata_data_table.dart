import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import 'metadata_data_row.dart';

class MetadataDataTable extends StatelessWidget {
  const MetadataDataTable(
      {Key? key, required this.xFile, required this.metadata})
      : super(key: key);

  final XFile? xFile;
  final Metadata metadata;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 0,
      dataRowHeight: 100,
      columns: [
        DataColumn(label: Container()),
        DataColumn(label: Container()),
      ],
      rows: [
        MetadataDataRow(
            "Artist",
            metadata.trackArtistNames != null
                ? metadata.trackArtistNames!.join(", ")
                : "null"),
        MetadataDataRow("Title", metadata.trackName ?? "null"),
        MetadataDataRow("File name", xFile != null ? xFile!.name : "Drop here")
      ],
    );
  }
}
