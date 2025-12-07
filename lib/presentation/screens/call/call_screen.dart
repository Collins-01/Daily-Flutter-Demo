// call_view_model.dart
import 'package:daily_flutter_demo/presentation/screens/call/call_screen_viewmodel.dart';
import 'package:daily_flutter_demo/presentation/screens/call/enums/enums.dart';
import 'package:daily_flutter_demo/presentation/screens/chat/chat_screen.dart';
import 'package:daily_flutter_demo/presentation/screens/participants/participants_screen.dart';
import 'package:daily_flutter_demo/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// call_screen.dart
import 'package:flutter/material.dart';

import 'models/call_participant_model.dart';

class CallScreen extends ConsumerWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(callViewModelProvider);
    final viewModel = ref.read(callViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.videoBackground,
      body: Stack(
        children: [
          // Video Grid
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 80,
                bottom: 200,
                left: 16,
                right: 16,
              ),
              child: state.viewMode == ViewMode.speaker
                  ? _buildSpeakerView(state.participants)
                  : _buildGridView(state.participants),
            ),
          ),

          // Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Call Timer
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              state.formattedDuration,
                              style: const TextStyle(
                                color: AppColors.textOnDark,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Participants Button
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ParticipantsScreen(),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.people,
                                color: AppColors.iconOnDark,
                                size: 14,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${state.participants.length}',
                                style: const TextStyle(
                                  color: AppColors.textOnDark,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom Control Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Main Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Mic Toggle
                          _ControlButton(
                            icon: state.isMicOn ? Icons.mic : Icons.mic_off,
                            isActive: state.isMicOn,
                            onTap: viewModel.toggleMic,
                          ),
                          const SizedBox(width: 12),
                          // Camera Toggle
                          _ControlButton(
                            icon: state.isCameraOn
                                ? Icons.videocam
                                : Icons.videocam_off,
                            isActive: state.isCameraOn,
                            onTap: viewModel.toggleCamera,
                          ),
                          const SizedBox(width: 12),
                          // End Call
                          _ControlButton(
                            icon: Icons.call_end,
                            isActive: false,
                            isEndCall: true,
                            onTap: viewModel.endCall,
                          ),
                          const SizedBox(width: 12),
                          // More Options
                          _ControlButton(
                            icon: Icons.more_vert,
                            isActive: true,
                            onTap: () {
                              // Show more options
                            },
                          ),
                          const SizedBox(width: 12),
                          // Chat
                          _ControlButton(
                            icon: Icons.chat_bubble_outline,
                            isActive: true,
                            badge: 3,
                            onTap: () {
                              // Open chat
                              //navigate to chat screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChatScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Secondary Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SecondaryControlButton(
                            icon: Icons.grid_view,
                            label: 'Grid',
                            isActive: state.viewMode == ViewMode.grid,
                            onTap: viewModel.toggleViewMode,
                          ),
                          const SizedBox(width: 24),
                          _SecondaryControlButton(
                            icon: Icons.fullscreen,
                            label: 'Full',
                            isActive: false,
                            onTap: () {
                              // Toggle fullscreen
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeakerView(List<CallParticipant> participants) {
    return Column(
      children: [
        // Main Speaker
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: _ParticipantTile(
              participant: participants[0],
              isLarge: true,
            ),
          ),
        ),
        // Other Participants
        Expanded(
          flex: 1,
          child: Row(
            children: participants
                .skip(1)
                .take(3)
                .map(
                  (p) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: _ParticipantTile(participant: p),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGridView(List<CallParticipant> participants) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: participants.length,
      itemBuilder: (context, index) {
        return _ParticipantTile(participant: participants[index]);
      },
    );
  }
}

class _ParticipantTile extends StatelessWidget {
  final CallParticipant participant;
  final bool isLarge;

  const _ParticipantTile({required this.participant, this.isLarge = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.videoBackgroundGradientStart,
            AppColors.videoBackgroundGradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: participant.isSpeaking
            ? Border.all(color: AppColors.primary, width: 3)
            : null,
      ),
      child: Stack(
        children: [
          // Camera Content
          Center(
            child: participant.cameraOn
                ? Container(
                    width: isLarge ? 96 : 64,
                    height: isLarge ? 96 : 64,
                    decoration: BoxDecoration(
                      color: AppColors.avatarBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        participant.name[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: isLarge ? 40 : 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.avatarText,
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: isLarge ? 96 : 64,
                    height: isLarge ? 96 : 64,
                    decoration: BoxDecoration(
                      color: AppColors.videoCameraOffBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.videocam_off,
                      size: isLarge ? 48 : 32,
                      color: AppColors.iconSecondary,
                    ),
                  ),
          ),

          // Name and Mic Status
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.overlayDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    participant.micOn ? Icons.mic : Icons.mic_off,
                    size: 12,
                    color: participant.micOn
                        ? AppColors.iconOnDark
                        : AppColors.error,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      participant.name,
                      style: TextStyle(
                        fontSize: isLarge ? 14 : 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textOnDark,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final bool isEndCall;
  final int? badge;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.isActive,
    this.isEndCall = false,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isEndCall
                  ? AppColors.error
                  : isActive
                  ? AppColors.videoCameraOffBackground
                  : AppColors.error,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.iconOnDark, size: 24),
          ),
          if (badge != null)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$badge',
                    style: const TextStyle(
                      color: AppColors.textOnPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SecondaryControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SecondaryControlButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.videoCameraOffBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.iconOnDark, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: AppColors.textOnDark, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
