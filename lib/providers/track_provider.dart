import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class Track {
  const Track({
    required this.artist,
    required this.title,
  });

  final String artist;
  final String title;

  Track copyWith(String? artist, String? title) {
    return Track(
      artist: artist ?? this.artist,
      title: title ?? this.title,
    );
  }
}

class TrackNotifier extends StateNotifier<Track> {
  TrackNotifier() : super(const Track(artist: "", title: ""));

  void update({String? artist, String? title}) {
    state = state.copyWith(artist, title);
  }
}

final trackProvider = StateNotifierProvider<TrackNotifier, Track>((ref) {
  return TrackNotifier();
});
