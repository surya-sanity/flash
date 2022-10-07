import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/models/chat_user.dart';
import 'package:stacked/stacked.dart';

class ChatUserListViewModel extends BaseViewModel {
  Stream<List<ChatUser>> get chatUserList {
    return FirebaseFirestore.instance
        .collection('flashUsers')
        .doc('fTygEXMDEzxXyMsbcNHB')
        .collection('chatUserList')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ChatUser.fromJson(e.data())).toList());
  }
}
