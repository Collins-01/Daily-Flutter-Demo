import 'package:daily_flutter/daily_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinCallConfig {
  /// This is the username of the user
  final String username;

  /// This is the call url
  final String callUrl;

  /// This is the flag to check if the call is video call or audio call.
  final bool isVideoCall;

  /// This is the flag to check if the mic is muted or not, before joining the call.
  final bool isMicMuted;

  /// This is the flag to check if the camera is muted or not, before joining the call.
  final bool isCameraMuted;

  JoinCallConfig({
    required this.username,
    required this.callUrl,
    this.isVideoCall = true,
    this.isMicMuted = false,
    this.isCameraMuted = false,
  });
}

/// This is the provider for the Daily SDK
class DailySdkProvider extends StateNotifier<CallClient?> {
  DailySdkProvider() : super(null);

  /// This method is used to check if daily sdk has been initialized.
  /// We are basicaly checking ig the state is null or not.
  /// By default, it is null.
  bool get isInitialized => state != null;

  /// This method is used to initialize the daily sdk.
  Future<void> initDailySdk() async {
    final daily = await CallClient.create();

    state = daily;
  }

  void _ensureSDKInitialized() {
    if (!isInitialized) {
      throw Exception('Daily SDK is not initialized');
    }
  }

  Future<void> joinCall({required JoinCallConfig config}) async {
    _ensureSDKInitialized();

    final callClient = state!;

    // set username
    await callClient.setUsername(config.username);

    //update mic state
    await callClient.setInputsEnabled(
      /// we are enabling the mic if the mic is not muted
      microphone: !config.isMicMuted,

      /// we are enabling the camera if the camera is not muted
      camera: !config.isCameraMuted,
    );

    await callClient.join(
      url: Uri.parse(config.callUrl),
      clientSettings: ClientSettingsUpdate.set(),
    );
  }

  void toggleMic() {
    _ensureSDKInitialized();

    final callClient = state!;
    bool currentMicState = callClient.inputs.microphone.isEnabled;

    /// basically, we are inverting the current state of the mic.
    /// If muted currently, we are enabling it.
    /// If enabled currently, we are muting it.
    callClient.setInputsEnabled(microphone: !currentMicState);
  }

  void toggleCamera() {
    _ensureSDKInitialized();

    final callClient = state!;
    bool currentCameraState = callClient.inputs.camera.isEnabled;

    /// basically, we are inverting the current state of the camera.
    /// If disabled currently, we are enabling it.
    /// If enabled currently, we are disabling it.
    callClient.setInputsEnabled(camera: !currentCameraState);
  }

  /// This method is used to leave the call.
  /// We are disabling the audio and video before leaving the call.
  /// When everything goes well, we are returning true.
  /// If something goes wrong, we are returning false.
  Future<bool> leaveCall() async {
    try {
      _ensureSDKInitialized();

      final callClient = state!;

      // disable audio
      await callClient.setInputsEnabled(microphone: false);

      //diable video
      await callClient.setInputsEnabled(camera: false);

      await callClient.leave();

      return true;
    } catch (e) {
      debugPrint("Error leaving current call: $e");
      return false;
    }
  }
}

final dailySdkProvider = StateNotifierProvider<DailySdkProvider, CallClient?>(
  (ref) => DailySdkProvider(),
);
