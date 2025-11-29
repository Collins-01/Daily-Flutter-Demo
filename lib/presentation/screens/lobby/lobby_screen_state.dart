import 'package:daily_flutter_demo/presentation/screens/lobby/enums/enums.dart';

class LobbyState {
  final String name;
  final bool cameraOn;
  final bool micOn;
  final CallType callType;
  final bool isJoining;

  LobbyState({
    this.name = '',
    this.cameraOn = true,
    this.micOn = true,
    this.callType = CallType.video,
    this.isJoining = false,
  });

  LobbyState copyWith({
    String? name,
    bool? cameraOn,
    bool? micOn,
    CallType? callType,
    bool? isJoining,
  }) {
    return LobbyState(
      name: name ?? this.name,
      cameraOn: cameraOn ?? this.cameraOn,
      micOn: micOn ?? this.micOn,
      callType: callType ?? this.callType,
      isJoining: isJoining ?? this.isJoining,
    );
  }

  bool get canJoin => name.trim().isNotEmpty && !isJoining;
}
