class CallParticipant {
  final String id;
  final String name;
  final bool isSpeaking;
  final bool micOn;
  final bool cameraOn;
  final bool isHost;

  CallParticipant({
    required this.id,
    required this.name,
    this.isSpeaking = false,
    this.micOn = true,
    this.cameraOn = true,
    this.isHost = false,
  });

  CallParticipant copyWith({
    String? id,
    String? name,
    bool? isSpeaking,
    bool? micOn,
    bool? cameraOn,
    bool? isHost,
  }) {
    return CallParticipant(
      id: id ?? this.id,
      name: name ?? this.name,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      micOn: micOn ?? this.micOn,
      cameraOn: cameraOn ?? this.cameraOn,
      isHost: isHost ?? this.isHost,
    );
  }
}
