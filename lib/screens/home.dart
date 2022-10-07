import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/locator.dart';
import 'package:flash/models/chat_user.dart';
import 'package:flash/models/flash_user.dart';
import 'package:flash/utils/size_config.dart';
import 'package:flash/viewmodels/auth_viewmodel.dart';
import 'package:flash/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ChatUserListViewModel>.reactive(
        viewModelBuilder: () => locator.get<ChatUserListViewModel>(),
        disposeViewModel: false,
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                GestureDetector(
                    onTap: () async {
                      locator.get<Authviewmodel>().signOut(context);
                    },
                    child: Icon(Icons.logout))
              ],
            ),
            body: SafeArea(
              child: StreamBuilder<List<ChatUser>>(
                stream: model.chatUserList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ChatUser>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container();
                      break;
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    default:
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: buildAvatar(),
                              title: Text(
                                snapshot.data[index].uId,
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data[index].lastMessage),
                                  Text(snapshot.data[index].lastMessageTime
                                      .millisecondsSinceEpoch
                                      .toString()),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          );
        });
  }

  Widget buildAvatar({String uid}) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('flashUsers')
          .doc('fTygEXMDEzxXyMsbcNHB')
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Container(
              height: SizeConfig.longside / 13,
              width: SizeConfig.longside / 13,
              child: CircularProgressIndicator());
        else if (snapshot.hasData) {
          FlashUser _flashUser = FlashUser.fromJson(snapshot.data.data());
          return Container(
            height: SizeConfig.longside / 13,
            width: SizeConfig.longside / 13,
            child: Stack(children: [
              Center(
                child: CircleAvatar(
                  radius: SizeConfig.longside / 27,
                  foregroundImage: NetworkImage(_flashUser.userAvatar),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _flashUser.online ? Colors.green : Colors.redAccent),
                ),
              ),
            ]),
          );
        }
        return Container(
          height: SizeConfig.longside / 13,
          width: SizeConfig.longside / 13,
        );
      },
    );
  }
}
