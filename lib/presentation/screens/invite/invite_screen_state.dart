import 'package:daily_flutter_demo/presentation/screens/invite/models/models.dart';

class InviteState {
  final String meetingLink;
  final String meetingId;
  final String passcode;
  final List<Contact> suggestedContacts;
  final List<String> selectedContactIds;
  final bool linkCopied;

  InviteState({
    required this.meetingLink,
    required this.meetingId,
    required this.passcode,
    this.suggestedContacts = const [],
    this.selectedContactIds = const [],
    this.linkCopied = false,
  });

  InviteState copyWith({
    String? meetingLink,
    String? meetingId,
    String? passcode,
    List<Contact>? suggestedContacts,
    List<String>? selectedContactIds,
    bool? linkCopied,
  }) {
    return InviteState(
      meetingLink: meetingLink ?? this.meetingLink,
      meetingId: meetingId ?? this.meetingId,
      passcode: passcode ?? this.passcode,
      suggestedContacts: suggestedContacts ?? this.suggestedContacts,
      selectedContactIds: selectedContactIds ?? this.selectedContactIds,
      linkCopied: linkCopied ?? this.linkCopied,
    );
  }
}
