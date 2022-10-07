import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash/locator.dart';
import 'package:flash/models/flash_user.dart';
import 'package:flash/services/services.dart';
import 'package:flash/utils/transformer.dart';

class DatabaseService {
  final CollectionReference flashUsersCollection =
      FirebaseFirestore.instance.collection('flashUsers');

  Future createUser(FlashUser user) async {
    try {
      return await flashUsersCollection.doc(user.uId).set(user.toJson());
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<String>> getUserAvatars() async {
    try {
      var result = await FirebaseStorage.instance.ref('avatars/').listAll();
      for (final item in result.items) {
        print(item.getDownloadURL());
      }
    } catch (e) {
      return null;
    }
  }

  Future changeUserOnlineStatus(bool online) async {
    await locator
        .get<DatabaseService>()
        .flashUsersCollection
        .doc(locator.get<AuthService>().auth.currentUser?.uid)
        .update({'online': online});
  }

  Future addRandomUsers(List<FlashUser> users) async {
    // final allUsers = await flashUsersCollection.get();
    for (final user in users) {
      final userDoc = flashUsersCollection.doc();
      final newUser = user.copyWith(uId: userDoc.id);

      await userDoc.set(newUser.toJson());
    }
    // if (allUsers.size != 0) {
    //   return;
    // } else {

    // }
  }

  Stream<List<FlashUser>> getUsers() => flashUsersCollection
      // .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Transformer.transformer(FlashUser.fromJson));

  // static Future uploadMessage(String idUser, String message) async {
  //   final refMessages =
  //       FirebaseFirestore.instance.collection('chats/$idUser/messages');

  //   final newMessage = Message(
  //     idUser: myId,
  //     urlAvatar: myUrlAvatar,
  //     username: myUsername,
  //     message: message,
  //     createdAt: DateTime.now(),
  //   );
  //   await refMessages.add(newMessage.toJson());

  //   final refUsers = FirebaseFirestore.instance.collection('users');
  //   await refUsers
  //       .doc(idUser)
  //       .update({UserField.lastMessageTime: DateTime.now()});
  // }

  // static Stream<List<Message>> getMessages(String idUser) =>
  //     FirebaseFirestore.instance
  //         .collection('chats/$idUser/messages')
  //         .orderBy(MessageField.createdAt, descending: true)
  //         .snapshots()
  //         .transform(Utils.transformer(Message.fromJson));
}
