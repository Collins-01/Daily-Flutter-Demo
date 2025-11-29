enum CallType { video, audio }

extension CallTypeExtension on CallType {
  String get label {
    switch (this) {
      case CallType.video:
        return 'Video';
      case CallType.audio:
        return 'Audio';
    }
  }

  bool get isVideo => this == CallType.video;
  bool get isAudio => this == CallType.audio;
}
