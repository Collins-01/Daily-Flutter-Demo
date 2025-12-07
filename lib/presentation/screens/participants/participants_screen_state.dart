import 'package:daily_flutter_demo/presentation/screens/call/models/call_participant_model.dart';

class ParticipantsState {
  final List<CallParticipant> participants;
  final String searchQuery;

  ParticipantsState({this.participants = const [], this.searchQuery = ''});

  ParticipantsState copyWith({
    List<CallParticipant>? participants,
    String? searchQuery,
  }) {
    return ParticipantsState(
      participants: participants ?? this.participants,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<CallParticipant> get filteredParticipants {
    if (searchQuery.isEmpty) {
      return participants;
    }
    return participants
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
