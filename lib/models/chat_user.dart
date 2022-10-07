import 'package:flash/utils/transformer.dart';

class ChatUser {
  final String uId;
  final String lastMessage;
  final DateTime lastMessageTime;

  const ChatUser({
    this.uId,
    this.lastMessage,
    this.lastMessageTime,
  });

  ChatUser copyWith({
    String uId,
    String lastMessage,
    DateTime lastMessageTime,
  }) =>
      ChatUser(
        uId: uId ?? this.uId,
        lastMessage: lastMessage ?? this.lastMessage,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  static ChatUser fromJson(Map<String, dynamic> json) => ChatUser(
        uId: json['uId'],
        lastMessage: json['lastMessage'],
        lastMessageTime: Transformer.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'lastMessage': lastMessage,
        'lastMessageTime': Transformer.fromDateTimeToJson(lastMessageTime),
      };
}
