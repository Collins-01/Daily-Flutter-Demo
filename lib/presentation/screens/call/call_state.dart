import 'dart:async';

import 'package:daily_flutter/daily_flutter.dart';
import 'package:daily_flutter_demo/presentation/screens/call/enums/view_mode.dart';

import 'models/call_participant_model.dart';

class CallState {
  final bool isMicOn;
  final bool isCameraOn;
  final ViewMode viewMode;
  final List<CallParticipant> participants;
  final Duration callDuration;
  final bool showParticipants;
  final StreamSubscription<Event>? eventSubscription;

  /// used to control the state of when the user is leaving the call.
  final bool isLeavingCall;

  CallState({
    this.isMicOn = true,
    this.isCameraOn = true,
    this.viewMode = ViewMode.speaker,
    this.participants = const [],
    this.callDuration = Duration.zero,
    this.showParticipants = false,
    this.eventSubscription,
    this.isLeavingCall = false,
  });

  CallState copyWith({
    bool? isMicOn,
    bool? isCameraOn,
    ViewMode? viewMode,
    List<CallParticipant>? participants,
    Duration? callDuration,
    bool? showParticipants,
    StreamSubscription<Event>? eventSubscription,
    bool setEventsSubscriptionToNull = false,
    bool? isLeavingCall,
  }) {
    return CallState(
      isMicOn: isMicOn ?? this.isMicOn,
      isCameraOn: isCameraOn ?? this.isCameraOn,
      viewMode: viewMode ?? this.viewMode,
      participants: participants ?? this.participants,
      callDuration: callDuration ?? this.callDuration,
      showParticipants: showParticipants ?? this.showParticipants,
      eventSubscription: setEventsSubscriptionToNull ? null : eventSubscription,
      isLeavingCall: isLeavingCall ?? this.isLeavingCall,
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
