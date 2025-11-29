import 'package:daily_flutter_demo/presentation/screens/call/models/participant_model.dart';
import 'package:daily_flutter_demo/presentation/screens/participants/participants_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParticipantsViewModel extends StateNotifier<ParticipantsState> {
  ParticipantsViewModel()
    : super(
        ParticipantsState(
          participants: [
            Participant(
              id: '1',
              name: 'John Doe',
              isHost: true,
              micOn: true,
              cameraOn: true,
              isSpeaking: true,
            ),
            Participant(
              id: '2',
              name: 'Sarah Smith',
              isHost: false,
              micOn: true,
              cameraOn: true,
              isSpeaking: false,
            ),
            Participant(
              id: '3',
              name: 'Mike Johnson',
              isHost: false,
              micOn: false,
              cameraOn: true,
              isSpeaking: false,
            ),
            Participant(
              id: '4',
              name: 'Emma Wilson',
              isHost: false,
              micOn: true,
              cameraOn: false,
              isSpeaking: false,
            ),
            Participant(
              id: '5',
              name: 'David Brown',
              isHost: false,
              micOn: true,
              cameraOn: true,
              isSpeaking: false,
            ),
            Participant(
              id: '6',
              name: 'Lisa Anderson',
              isHost: false,
              micOn: false,
              cameraOn: false,
              isSpeaking: false,
            ),
          ],
        ),
      );

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void toggleParticipantMic(String participantId) {
    final updatedParticipants = state.participants.map((p) {
      if (p.id == participantId) {
        return p.copyWith(micOn: !p.micOn);
      }
      return p;
    }).toList();

    state = state.copyWith(participants: updatedParticipants);
  }

  void toggleParticipantCamera(String participantId) {
    final updatedParticipants = state.participants.map((p) {
      if (p.id == participantId) {
        return p.copyWith(cameraOn: !p.cameraOn);
      }
      return p;
    }).toList();

    state = state.copyWith(participants: updatedParticipants);
  }

  void removeParticipant(String participantId) {
    final updatedParticipants = state.participants
        .where((p) => p.id != participantId)
        .toList();
    state = state.copyWith(participants: updatedParticipants);
  }
}

final participantsViewModelProvider =
    StateNotifierProvider<ParticipantsViewModel, ParticipantsState>(
      (ref) => ParticipantsViewModel(),
    );
