import 'package:daily_flutter_demo/presentation/screens/call/models/participant_model.dart';
import 'package:daily_flutter_demo/presentation/screens/invite/invite_screen.dart';
import 'package:daily_flutter_demo/presentation/screens/participants/participants_screen_viewmodel.dart';
import 'package:daily_flutter_demo/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParticipantsScreen extends ConsumerWidget {
  const ParticipantsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(participantsViewModelProvider);
    final viewModel = ref.read(participantsViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.iconPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Participants',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${state.participants.length} in call',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.surface,
            child: TextField(
              onChanged: viewModel.setSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search participants...',
                hintStyle: const TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.iconSecondary,
                  size: 20,
                ),
                filled: true,
                fillColor: AppColors.surfaceSecondary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Participants List
          Expanded(
            child: state.filteredParticipants.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: state.filteredParticipants.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      indent: 72,
                      color: AppColors.border,
                    ),
                    itemBuilder: (context, index) {
                      final participant = state.filteredParticipants[index];
                      return _ParticipantItem(
                        participant: participant,
                        onMoreTap: () => _showParticipantOptions(
                          context,
                          participant,
                          viewModel,
                        ),
                      );
                    },
                  ),
          ),

          // Invite Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                top: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InviteScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.person_add, size: 20),
                  label: const Text(
                    'Invite People',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    elevation: 8,
                    shadowColor: AppColors.shadowPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search,
              color: AppColors.iconSecondary,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'No participants found',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  void _showParticipantOptions(
    BuildContext context,
    Participant participant,
    ParticipantsViewModel viewModel,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Participant Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.avatarBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        participant.name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.avatarText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          participant.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (participant.isHost)
                          const Text(
                            'Host',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Options
            if (!participant.isHost) ...[
              _OptionItem(
                icon: Icons.message,
                label: 'Send Message',
                onTap: () {
                  Navigator.pop(context);
                  // Open chat with participant
                },
              ),
              _OptionItem(
                icon: Icons.person_remove,
                label: 'Remove from Call',
                isDestructive: true,
                onTap: () {
                  Navigator.pop(context);
                  viewModel.removeParticipant(participant.id);
                },
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ParticipantItem extends StatelessWidget {
  final Participant participant;
  final VoidCallback onMoreTap;

  const _ParticipantItem({required this.participant, required this.onMoreTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar with speaking indicator
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: participant.isSpeaking
                        ? Border.all(color: AppColors.primary, width: 2)
                        : null,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.avatarBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        participant.name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.avatarText,
                        ),
                      ),
                    ),
                  ),
                ),
                // Host Badge
                if (participant.isHost)
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAB308), // Yellow
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 2),
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        participant.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (participant.isHost) ...[
                        const SizedBox(width: 6),
                        const Text(
                          '(Host)',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Status Icons
            Row(
              children: [
                // Mic Status
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: participant.micOn
                        ? AppColors.surfaceSecondary
                        : const Color(0xFFFEE2E2), // Red 100
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    participant.micOn ? Icons.mic : Icons.mic_off,
                    size: 16,
                    color: participant.micOn
                        ? AppColors.iconPrimary
                        : AppColors.error,
                  ),
                ),
                const SizedBox(width: 8),
                // Camera Status
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: participant.cameraOn
                        ? AppColors.surfaceSecondary
                        : const Color(0xFFFEE2E2), // Red 100
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    participant.cameraOn ? Icons.videocam : Icons.videocam_off,
                    size: 16,
                    color: participant.cameraOn
                        ? AppColors.iconPrimary
                        : AppColors.error,
                  ),
                ),
                const SizedBox(width: 8),
                // More Options
                GestureDetector(
                  onTap: onMoreTap,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.more_vert,
                      size: 16,
                      color: AppColors.iconPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback onTap;

  const _OptionItem({
    required this.icon,
    required this.label,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.error : AppColors.iconPrimary,
        size: 24,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
    );
  }
}
