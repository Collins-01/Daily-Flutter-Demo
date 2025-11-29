import 'package:daily_flutter_demo/presentation/screens/call/enums/view_mode.dart';

import 'models/participant_model.dart';

class CallState {
  final bool isMicOn;
  final bool isCameraOn;
  final ViewMode viewMode;
  final List<Participant> participants;
  final Duration callDuration;
  final bool showParticipants;

  CallState({
    this.isMicOn = true,
    this.isCameraOn = true,
    this.viewMode = ViewMode.speaker,
    this.participants = const [],
    this.callDuration = Duration.zero,
    this.showParticipants = false,
  });

  CallState copyWith({
    bool? isMicOn,
    bool? isCameraOn,
    ViewMode? viewMode,
    List<Participant>? participants,
    Duration? callDuration,
    bool? showParticipants,
  }) {
    return CallState(
      isMicOn: isMicOn ?? this.isMicOn,
      isCameraOn: isCameraOn ?? this.isCameraOn,
      viewMode: viewMode ?? this.viewMode,
      participants: participants ?? this.participants,
      callDuration: callDuration ?? this.callDuration,
      showParticipants: showParticipants ?? this.showParticipants,
    );
  }

  String get formattedDuration {
    final hours = callDuration.inHours;
    final minutes = callDuration.inMinutes.remainder(60);
    final seconds = callDuration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
