class Participant {
  final String id;
  final String name;
  final bool isSpeaking;
  final bool micOn;
  final bool cameraOn;

  Participant({
    required this.id,
    required this.name,
    this.isSpeaking = false,
    this.micOn = true,
    this.cameraOn = true,
  });

  Participant copyWith({
    String? id,
    String? name,
    bool? isSpeaking,
    bool? micOn,
    bool? cameraOn,
  }) {
    return Participant(
      id: id ?? this.id,
      name: name ?? this.name,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      micOn: micOn ?? this.micOn,
      cameraOn: cameraOn ?? this.cameraOn,
    );
  }
}
