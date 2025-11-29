import 'package:daily_flutter_demo/presentation/screens/chat/chat_screen_state.dart';
import 'package:daily_flutter_demo/presentation/screens/chat/models/message_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatViewModel extends StateNotifier<ChatState> {
  ChatViewModel()
    : super(
        ChatState(
          messages: [
            MessageModel(
              id: '1',
              sender: 'John Doe',
              text: 'Hey everyone! Thanks for joining the call.',
              time: '9:30 AM',
              isMe: false,
            ),
            MessageModel(
              id: '2',
              sender: 'You',
              text: 'Happy to be here!',
              time: '9:31 AM',
              isMe: true,
            ),
            MessageModel(
              id: '3',
              sender: 'Sarah Smith',
              text: 'Can everyone see my screen?',
              time: '9:32 AM',
              isMe: false,
            ),
            MessageModel(
              id: '4',
              sender: 'You',
              text: 'Yes, looking good!',
              time: '9:32 AM',
              isMe: true,
            ),
            MessageModel(
              id: '5',
              sender: 'Mike Johnson',
              text: 'I have a question about the last slide',
              time: '9:33 AM',
              isMe: false,
            ),
            MessageModel(
              id: '6',
              sender: 'Emma Wilson',
              text: 'Same here, can we go back?',
              time: '9:33 AM',
              isMe: false,
            ),
            MessageModel(
              id: '7',
              sender: 'John Doe',
              text: 'Sure, let me share that again',
              time: '9:34 AM',
              isMe: false,
            ),
          ],
        ),
      );

  void setMessageText(String text) {
    state = state.copyWith(messageText: text);
  }

  Future<void> sendMessage() async {
    if (!state.canSend) return;

    final newMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'You',
      text: state.messageText,
      time: _getCurrentTime(),
      isMe: true,
    );

    state = state.copyWith(isSending: true);

    // Simulate sending
    await Future.delayed(const Duration(milliseconds: 300));

    state = state.copyWith(
      messages: [...state.messages, newMessage],
      messageText: '',
      isSending: false,
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, ChatState>(
  (ref) => ChatViewModel(),
);
