import 'dart:io';

import 'package:chatapp/blocs/chat_room_bloc.dart';
import 'package:chatapp/models/chat_message.dart';
import 'package:chatapp/widgets/zero_size_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  ChatRoomBloc _chatRoomBloc;

  @override
  void initState() {
    super.initState();
    _chatRoomBloc = ChatRoomBloc();
  }

  @override
  void dispose() {
    _chatRoomBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _chatRoomBloc,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
//            again development random name
            title: Text("James"),
            actions: <Widget>[
              Icon(Icons.more_vert),
              SizedBox(width: 12),
            ],
          ),
          body: ChatContent(),
        ),
      ),
    );
  }
}

class ChatContent extends StatelessWidget {
  const ChatContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: ChatRoomList()),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: SendMessageWidget(),
        )
      ],
    );
  }
}

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({Key key}) : super(key: key);

  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
//            onEditingComplete: _sendMessage,
            controller: textController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter Message'),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          color: Colors.green,
          icon: Icon(Icons.send),
          onPressed: _sendMessage,
        ),
        IconButton(
          color: Colors.green,
          icon: Icon(Icons.camera_alt),
          onPressed: () => getImage(context),
        ),
      ],
    );
  }

  void _sendMessage() {
    BlocProvider.of<ChatRoomBloc>(context).sendMessage(textController.text);
    textController.clear();
  }
}

class ChatRoomList extends StatelessWidget {
//  final List<ChatMessage> list;

  const ChatRoomList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatMessage>>(
      stream: BlocProvider.of<ChatRoomBloc>(context).sc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            reverse: true,
            itemBuilder: (context, index) {
              ChatMessage chatMessage = snapshot.data[index];
              if (chatMessage.isSameUserMess) {
                return RightChatMessage(chatMessage);
              }
              return ChatLeftMessage(chatMessage.mes);
            },
          );
        }
        return ZeroSizeContainer();
      },
    );
  }
}

class RightChatMessage extends StatelessWidget {
  final ChatMessage chatMessage;

  const RightChatMessage(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: ZeroSizeContainer()),
          Card(
            elevation: 4,
            child: chatMessage.isImage
                ? Image.file(
                    File(chatMessage.imagePath),
                    height: 220,
                    width: 220,
                    fit: BoxFit.cover,
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      chatMessage.mes,
                      textAlign: TextAlign.end,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class ChatLeftMessage extends StatelessWidget {
  final String mes;

  const ChatLeftMessage(this.mes, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Card(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(mes),
          )),
          Expanded(flex: 1, child: ZeroSizeContainer())
        ],
      ),
    );
  }
}

void getImage(BuildContext context) async {
  final PickedFile pickedFile =
      await ImagePicker().getImage(source: ImageSource.gallery);
  BlocProvider.of<ChatRoomBloc>(context).sendImage(pickedFile.path);
}
