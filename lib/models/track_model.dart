import 'package:flutter/material.dart';

class TrackModel with ChangeNotifier {
  String _artist = "";
  String _title = "";

  String get artist => _artist;
  String get title => _title;

  void update(String artist, String title) {
    _artist = artist;
    _title = title;
    notifyListeners();
  }
}
