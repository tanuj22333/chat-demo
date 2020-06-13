import 'package:chatapp/screens/chat_room_screen.dart';
import 'package:chatapp/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Chat App"),
        actions: <Widget>[
          Icon(Icons.search),
          PopupMenuButton<String>(
            onSelected: (value) => _onMenuItemPressed(context, value),
            itemBuilder: (BuildContext context) {
              return ["Profile"].map((ele) {
                return PopupMenuItem<String>(
                  value: ele,
                  child: Text(ele),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: AllChatList(),
    );
  }

  void _onMenuItemPressed(BuildContext context, String value) {
    if ("Profile".contains(value)) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProfileScreen()),
      );
    }
  }
}

class AllChatList extends StatelessWidget {
  const AllChatList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
//      development random value
      itemCount: 25,
      itemBuilder: (context, index) {
        return AllChatListItem();
      },
    );
  }
}

class AllChatListItem extends StatelessWidget {
  const AllChatListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _chatItemPressed(context),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(backgroundColor: Colors.grey),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Mary Com", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("12:12",
                    style: TextStyle(color: Colors.grey, fontSize: 14))
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: Text("Some message here"),
            ),
          ),
          Divider(height: 10),
        ],
      ),
    );
  }

  void _chatItemPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ChatRoomScreen()),
    );
  }
}
