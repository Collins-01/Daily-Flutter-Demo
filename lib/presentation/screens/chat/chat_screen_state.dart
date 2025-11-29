import 'models/message_model.dart';

class ChatState {
  final List<MessageModel> messages;
  final String messageText;
  final bool isSending;

  ChatState({
    this.messages = const [],
    this.messageText = '',
    this.isSending = false,
  });

  ChatState copyWith({
    List<MessageModel>? messages,
    String? messageText,
    bool? isSending,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      messageText: messageText ?? this.messageText,
      isSending: isSending ?? this.isSending,
    );
  }

  bool get canSend => messageText.trim().isNotEmpty && !isSending;
}
