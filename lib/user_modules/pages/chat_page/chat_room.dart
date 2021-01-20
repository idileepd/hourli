import 'dart:async';
// import 'dart:io';
//
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
// import 'package:flutter_chat_app/ChatMessageListItem.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:hourli/user_modules/pages/chat_page/chat_list_item.dart';

// final googleSignIn = new GoogleSignIn();
// final analytics = new FirebaseAnalytics();
// final auth = FirebaseAuth.instance;
// var currentUserEmail;
// var _scaffoldContext;

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposingMessage = false;
  final _userController = Get.find<UserController>();

  final reference = FirebaseDatabase.instance.reference().child('messages');

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text("Flutter Chat App"),
        //   elevation:
        //       Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        //   actions: <Widget>[
        //     new IconButton(
        //         icon: new Icon(Icons.exit_to_app), onPressed: )
        //   ],
        // ),
        body: new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(
              query: reference,
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              sort: (a, b) => b.key.compareTo(a.key),
              //comparing timestamp of messages to check which one would appear first
              itemBuilder: (_, DataSnapshot messageSnapshot,
                  Animation<double> animation, __) {
                // print(messageSnapshot.value);
                // print(messageSnapshot);

                return ChatMessageListItem(
                  messageSnapshot: messageSnapshot,
                  animation: animation,
                  currentUserUserName:
                      _userController.firestoreUserStream.value.userName,
                  isLeft: !(messageSnapshot.value['userName'] ==
                          _userController.firestoreUserStream.value.userName) ??
                      true,
                );
                // return Text('cool');
                // return _buildItem();
              },
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
          new Builder(builder: (BuildContext context) {
            // _scaffoldContext = context;
            return new Container(width: 0.0, height: 0.0);
          })
        ],
      ),
      decoration: Theme.of(context).platform == TargetPlatform.iOS
          ? new BoxDecoration(
              border: new Border(
                  top: new BorderSide(
              color: Colors.grey[200],
            )))
          : null,
    ));
  }

  // Widget _buildItem() {
  //   return Text('dsd');
  // }

  CupertinoButton getIOSSendButton() {
    return new CupertinoButton(
      child: new Text("Send"),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                  icon: new Icon(
                    Icons.photo_camera,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {},
                  // onPressed: () async {
                  //   await _ensureLoggedIn();
                  //   File imageFile = await ImagePicker.pickImage();
                  //   int timestamp = new DateTime.now().millisecondsSinceEpoch;
                  //   StorageReference storageReference = FirebaseStorage.instance
                  //       .ref()
                  //       .child("img_" + timestamp.toString() + ".jpg");
                  //   StorageUploadTask uploadTask =
                  //       storageReference.put(imageFile);
                  //   Uri downloadUrl = (await uploadTask.future).downloadUrl;
                  //   _sendMessage(
                  //       messageText: null, imageUrl: downloadUrl.toString());
                  // },
                ),
              ),
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? getIOSSendButton()
                    : getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    setState(() {
      _isComposingMessage = false;
    });

    _sendMessage(messageText: text, imageUrl: null);
  }

  void _sendMessage({String messageText, String imageUrl}) {
    reference.push().set({
      'message': messageText,
      'userName': _userController.firestoreUserStream.value.userName,
      // 'imageUrl': null,
      'diaplayName': _userController.firestoreUserStream.value.displayName,
      'senderPhotoUrl': _userController.firestoreUserStream.value.photoUrl,
    });

    // analytics.logEvent(name: 'send_message');
  }
}
