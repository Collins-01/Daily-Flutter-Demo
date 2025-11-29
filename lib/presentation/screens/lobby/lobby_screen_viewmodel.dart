import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:daily_flutter_demo/presentation/screens/lobby/enums/enums.dart';
import 'package:daily_flutter_demo/presentation/screens/lobby/lobby_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LobbyViewModel extends StateNotifier<LobbyState> {
  LobbyViewModel() : super(LobbyState());

  Future<void> requestPermissions() async {
    if (state.callType == CallType.audio) {
      await Permission.microphone.request();
    } else {
      await [Permission.camera, Permission.microphone].request();
    }
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void toggleCamera() {
    if (state.callType == CallType.video) {
      state = state.copyWith(cameraOn: !state.cameraOn);
    }
  }

  void toggleMic() {
    state = state.copyWith(micOn: !state.micOn);
  }

  void setCallType(CallType type) {
    state = state.copyWith(
      callType: type,
      cameraOn: type == CallType.video ? state.cameraOn : false,
    );
  }

  Future<void> joinCall(BuildContext context) async {
    if (!state.canJoin) return;

    state = state.copyWith(isJoining: true);

    // Simulate joining call
    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted) {
      Navigator.pushNamed(context, '/call');
    }

    state = state.copyWith(isJoining: false);
  }
}

final lobbyViewModelProvider =
    StateNotifierProvider<LobbyViewModel, LobbyState>(
      (ref) => LobbyViewModel(),
    );
