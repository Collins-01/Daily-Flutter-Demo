import 'package:daily_flutter_demo/presentation/screens/invite/invite_screen_state.dart';
import 'package:daily_flutter_demo/presentation/screens/invite/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InviteViewModel extends StateNotifier<InviteState> {
  InviteViewModel()
    : super(
        InviteState(
          meetingLink: 'https://meet.app/join/abc-defg-hij',
          meetingId: '123 456 789',
          passcode: '987654',
          suggestedContacts: [
            Contact(
              id: '1',
              name: 'Alex Johnson',
              email: 'alex@example.com',
              avatar: 'A',
            ),
            Contact(
              id: '2',
              name: 'Maria Garcia',
              email: 'maria@example.com',
              avatar: 'M',
            ),
            Contact(
              id: '3',
              name: 'James Wilson',
              email: 'james@example.com',
              avatar: 'J',
            ),
            Contact(
              id: '4',
              name: 'Sophia Lee',
              email: 'sophia@example.com',
              avatar: 'S',
            ),
          ],
        ),
      );

  Future<void> copyLink() async {
    // In a real app, use flutter/services Clipboard
    // await Clipboard.setData(ClipboardData(text: state.meetingLink));

    state = state.copyWith(linkCopied: true);

    // Reset after 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(linkCopied: false);
  }

  void toggleContact(String contactId) {
    final selectedIds = List<String>.from(state.selectedContactIds);

    if (selectedIds.contains(contactId)) {
      selectedIds.remove(contactId);
    } else {
      selectedIds.add(contactId);
    }

    state = state.copyWith(selectedContactIds: selectedIds);
  }

  Future<void> shareLink() async {
    // In a real app, use share_plus package
    // await Share.share(state.meetingLink);
  }

  Future<void> inviteViaEmail() async {
    // Open email composer with pre-filled content
    // url_launcher: mailto:?subject=...&body=...
  }

  Future<void> inviteViaSMS() async {
    // Open SMS app with pre-filled message
    // url_launcher: sms:?body=...
  }

  Future<void> sendInvitations() async {
    // Send invitations to selected contacts
    final selectedContacts = state.suggestedContacts
        .where((c) => state.selectedContactIds.contains(c.id))
        .toList();

    // Process invitations
    await Future.delayed(const Duration(seconds: 1));

    // Clear selection
    state = state.copyWith(selectedContactIds: []);
  }
}

final inviteViewModelProvider =
    StateNotifierProvider<InviteViewModel, InviteState>(
      (ref) => InviteViewModel(),
    );
