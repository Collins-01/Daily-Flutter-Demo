import 'package:daily_flutter_demo/presentation/screens/lobby/enums/enums.dart';
import 'package:daily_flutter_demo/presentation/screens/lobby/lobby_screen_viewmodel.dart';
import 'package:daily_flutter_demo/theme/app_colors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LobbyScreen extends ConsumerWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lobbyViewModelProvider);
    final viewModel = ref.read(lobbyViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Video Preview Card
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.videoBackgroundGradientStart,
                      AppColors.videoBackgroundGradientEnd,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowDefault,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Camera Preview Content
                    Center(
                      child: state.cameraOn && state.callType == CallType.video
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Avatar
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.avatarBackground,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.name.isNotEmpty
                                          ? state.name[0].toUpperCase()
                                          : 'U',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.avatarText,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Camera Preview',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textOnDark,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.videoCameraOffBackground,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    state.callType == CallType.audio
                                        ? Icons.phone
                                        : Icons.videocam_off,
                                    size: 60,
                                    color: AppColors.iconSecondary,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  state.callType == CallType.audio
                                      ? 'Audio Only Call'
                                      : 'Camera is off',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                    ),

                    // Settings Button
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.overlayDark,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: AppColors.iconOnDark,
                            size: 20,
                          ),
                          onPressed: () {
                            // Open settings
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Call Type Selector
              Row(
                children: [
                  Expanded(
                    child: _CallTypeButton(
                      icon: Icons.videocam,
                      label: 'Video Call',
                      isSelected: state.callType == CallType.video,
                      onTap: () => viewModel.setCallType(CallType.video),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CallTypeButton(
                      icon: Icons.phone,
                      label: 'Audio Call',
                      isSelected: state.callType == CallType.audio,
                      onTap: () => viewModel.setCallType(CallType.audio),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Name Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: viewModel.setName,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle: const TextStyle(color: AppColors.textTertiary),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.border,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.border,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.borderFocus,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Media Controls
              Row(
                children: [
                  if (state.callType == CallType.video)
                    Expanded(
                      child: _MediaControlButton(
                        icon: state.cameraOn
                            ? Icons.videocam
                            : Icons.videocam_off,
                        label: state.cameraOn ? 'Camera On' : 'Camera Off',
                        isActive: state.cameraOn,
                        onTap: viewModel.toggleCamera,
                      ),
                    ),
                  if (state.callType == CallType.video)
                    const SizedBox(width: 12),
                  Expanded(
                    child: _MediaControlButton(
                      icon: state.micOn ? Icons.mic : Icons.mic_off,
                      label: state.micOn ? 'Mic On' : 'Mic Off',
                      isActive: state.micOn,
                      onTap: viewModel.toggleMic,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Join Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: state.canJoin
                      ? () => viewModel.joinCall(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.canJoin
                        ? AppColors.primary
                        : AppColors.buttonDisabled,
                    foregroundColor: state.canJoin
                        ? AppColors.textOnPrimary
                        : AppColors.buttonTextDisabled,
                    elevation: state.canJoin ? 8 : 0,
                    shadowColor: AppColors.shadowPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: AppColors.buttonDisabled,
                    disabledForegroundColor: AppColors.buttonTextDisabled,
                  ),
                  child: state.isJoining
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.textOnPrimary,
                            ),
                          ),
                        )
                      : const Text(
                          'Join Call',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // Info Text
              Text(
                state.callType == CallType.video
                    ? 'Your camera and microphone settings will be preserved when you join'
                    : 'Audio-only call - no camera will be used',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CallTypeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CallTypeButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.buttonInactive,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.shadowPrimary,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? AppColors.iconOnPrimary
                  : AppColors.buttonTextInactive,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppColors.textOnPrimary
                    : AppColors.buttonTextInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MediaControlButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isActive ? AppColors.buttonInactive : AppColors.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? AppColors.iconPrimary : AppColors.iconOnPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? AppColors.buttonTextInactive
                    : AppColors.textOnPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
