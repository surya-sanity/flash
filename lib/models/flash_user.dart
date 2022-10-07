import 'package:flash/utils/transformer.dart';

// class FlashUser {
//   String uId;
//   String userName;
//   String userAvatar;
//   bool online;
//   String userEmail;
//   DateTime createdAt;
//   FlashUser({
//     this.uId,
//     this.userName,
//     this.userAvatar,
//     this.online,
//     this.userEmail,
//     this.createdAt,
//   });

//   fromJson(Map<String, dynamic> json) {
//     uId = json['uId'] as String;
//     userName = json['userName'] as String;
//     userAvatar = json['userAvatar'] as String;
//     userEmail = json['userEmail'] as String;
//     createdAt = json['createdAt'] as DateTime;
//     online = json['online'] as bool;
//     return this;
//   }

//   Map<String, dynamic> toJson() => {
//         'uId': uId,
//         'userName': userName,
//         'userAvatar': userAvatar,
//         'userEmail': userEmail,
//         'online': online,
//         'createdAt': createdAt,
//       };
// }

class FlashUser {
  final String uId;
  final String userName;
  final String userAvatar;
  final String userEmail;
  final bool online;
  final DateTime createdAt;
  // final DateTime lastMessageTime;

  const FlashUser({
    this.uId,
    this.userName,
    this.userAvatar,
    this.userEmail,
    this.online,
    this.createdAt,
    // this.lastMessageTime,
  });

  FlashUser copyWith({
    String uId,
    String userName,
    String userAvatar,
    String userEmail,
    bool online,
    DateTime createdAt,
    // DateTime lastMessageTime,
  }) =>
      FlashUser(
        uId: uId ?? this.uId,
        userName: userName ?? this.userName,
        userAvatar: userAvatar ?? this.userAvatar,
        userEmail: userEmail ?? this.userEmail,
        online: online ?? this.online,
        createdAt: createdAt ?? this.createdAt,
        // lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  static FlashUser fromJson(Map<String, dynamic> json) => FlashUser(
        uId: json['uId'],
        userName: json['userName'],
        userAvatar: json['userAvatar'],
        userEmail: json['userEmail'],
        online: json['online'],
        createdAt: Transformer.toDateTime(json['createdAt']),
        // lastMessageTime: Transformer.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'userName': userName,
        'userAvatar': userAvatar,
        'userEmail': userEmail,
        'online': online,
        'createdAt': Transformer.fromDateTimeToJson(createdAt),
        // 'lastMessageTime': Transformer.fromDateTimeToJson(lastMessageTime),
      };
}

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}
