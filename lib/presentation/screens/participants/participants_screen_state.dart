import 'package:daily_flutter_demo/presentation/screens/call/models/participant_model.dart';

class ParticipantsState {
  final List<Participant> participants;
  final String searchQuery;

  ParticipantsState({this.participants = const [], this.searchQuery = ''});

  ParticipantsState copyWith({
    List<Participant>? participants,
    String? searchQuery,
  }) {
    return ParticipantsState(
      participants: participants ?? this.participants,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Participant> get filteredParticipants {
    if (searchQuery.isEmpty) {
      return participants;
    }
    return participants
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
