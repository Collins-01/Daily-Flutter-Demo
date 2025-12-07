import 'dart:async';

import 'package:daily_flutter_demo/presentation/screens/call/call_state.dart';
import 'package:daily_flutter_demo/presentation/screens/call/enums/enums.dart';
import 'package:daily_flutter_demo/providers/providers.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift_alert/swift_alert.dart';

import 'models/call_participant_model.dart';

final participants = [
  CallParticipant(
    id: '1',
    name: 'John Doe',
    isSpeaking: true,
    micOn: true,
    cameraOn: true,
  ),
  CallParticipant(
    id: '2',
    name: 'Sarah Smith',
    isSpeaking: false,
    micOn: true,
    cameraOn: true,
  ),
  CallParticipant(
    id: '3',
    name: 'Mike Johnson',
    isSpeaking: false,
    micOn: false,
    cameraOn: true,
  ),
  CallParticipant(
    id: '4',
    name: 'Emma Wilson',
    isSpeaking: false,
    micOn: true,
    cameraOn: false,
  ),
];

class CallViewModel extends StateNotifier<CallState> {
  /// instance of daily sdk provider
  DailySdkProvider dailySDK;
  Timer? _timer;

  CallViewModel(this.dailySDK) : super(CallState(participants: participants)) {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        callDuration: state.callDuration + const Duration(seconds: 1),
      );
    });
  }

  /// Toggles the microphone state (on/off) for the current call.
  ///
  /// This method:
  /// 1. Toggles the microphone state in the Daily SDK
  /// 2. Updates the local state to reflect the new microphone state
  void toggleMic() {
    dailySDK.toggleMic();
    state = state.copyWith(isMicOn: !state.isMicOn);
  }

  /// Toggles the camera state (on/off) for the current call.
  ///
  /// This method:
  /// 1. Toggles the camera state in the Daily SDK
  /// 2. Updates the local state to reflect the new camera state
  void toggleCamera() {
    dailySDK.toggleCamera();
    state = state.copyWith(isCameraOn: !state.isCameraOn);
  }

  void toggleViewMode() {
    state = state.copyWith(
      viewMode: state.viewMode == ViewMode.speaker
          ? ViewMode.grid
          : ViewMode.speaker,
    );
  }

  void toggleParticipants() {
    state = state.copyWith(showParticipants: !state.showParticipants);
  }

  void endCall({VoidCallback? onLeaveCallback}) async {
    // _timer?.cancel();

    // Navigate back or to end call screen
    try {
      state = state.copyWith(isLeavingCall: true);
      final result = await dailySDK.leaveCall();
      if (result) {
        state = state.copyWith(isLeavingCall: false);
        onLeaveCallback?.call();
      }
    } catch (e) {
      state = state.copyWith(isLeavingCall: false);
      debugPrint(e.toString());
      SwiftAlert.show(message: e.toString(), type: NotificationType.error);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final callViewModelProvider = StateNotifierProvider<CallViewModel, CallState>(
  ///
  (ref) => CallViewModel(ref.read(dailySdkProvider.notifier)),
);
