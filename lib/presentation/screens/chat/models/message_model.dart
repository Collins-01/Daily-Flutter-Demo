class MessageModel {
  final String id;
  final String sender;
  final String text;
  final String time;
  final bool isMe;

  MessageModel({
    required this.id,
    required this.sender,
    required this.text,
    required this.time,
    required this.isMe,
  });
}
