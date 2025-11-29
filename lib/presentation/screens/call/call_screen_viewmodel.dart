import 'dart:async';

import 'package:daily_flutter_demo/presentation/screens/call/call_state.dart';
import 'package:daily_flutter_demo/presentation/screens/call/enums/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/participant_model.dart';

class CallViewModel extends StateNotifier<CallState> {
  Timer? _timer;

  CallViewModel()
    : super(
        CallState(
          participants: [
            Participant(
              id: '1',
              name: 'John Doe',
              isSpeaking: true,
              micOn: true,
              cameraOn: true,
            ),
            Participant(
              id: '2',
              name: 'Sarah Smith',
              isSpeaking: false,
              micOn: true,
              cameraOn: true,
            ),
            Participant(
              id: '3',
              name: 'Mike Johnson',
              isSpeaking: false,
              micOn: false,
              cameraOn: true,
            ),
            Participant(
              id: '4',
              name: 'Emma Wilson',
              isSpeaking: false,
              micOn: true,
              cameraOn: false,
            ),
          ],
        ),
      ) {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        callDuration: state.callDuration + const Duration(seconds: 1),
      );
    });
  }

  void toggleMic() {
    state = state.copyWith(isMicOn: !state.isMicOn);
  }

  void toggleCamera() {
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

  void endCall() {
    _timer?.cancel();
    // Navigate back or to end call screen
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final callViewModelProvider = StateNotifierProvider<CallViewModel, CallState>(
  (ref) => CallViewModel(),
);
