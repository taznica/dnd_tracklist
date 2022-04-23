import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import 'metadata_data_row.dart';

class MetadataDataTable extends StatelessWidget {
  const MetadataDataTable(
      {Key? key, required this.metadata})
      : super(key: key);

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
                : ""),
        MetadataDataRow("Title", getTitle()),
      ],
    );
  }

  String getTitle() {
    if (metadata.trackName != null) {
      return metadata.trackName!;
    }
    else if(metadata.filePath != null) {
      var reg = RegExp(r"[^/]+(?=\.)");
      String? fileName = reg.allMatches(metadata.filePath!).last.group(0);
      return fileName ?? "";
    }
    else {
      return "";
    }
  }
}
