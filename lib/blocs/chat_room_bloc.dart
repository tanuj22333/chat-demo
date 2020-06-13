import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/http_events.dart';
import 'package:chatapp/http_states.dart';
import 'package:chatapp/models/chat_message.dart';

class ChatRoomBloc extends Bloc<HttpEvent, HttpState> {
  final List<String> dummyMesList = [
    "Hi",
    "Great!!! You are good",
    "How are you :)",
    "I am always happy\nto help you"
  ];
  final StreamController<List<ChatMessage>> sc = StreamController();
  /// used to send dummy messages
  bool isRunning = true;
  List<ChatMessage> _list = [];

  @override
  HttpState get initialState {
    startMessageStream();
    return InitialState();
  }

  @override
  Stream<HttpState> mapEventToState(HttpEvent event) async* {
    if (event is SendLocalMessage) {
      _list.insert(0, ChatMessage(event.msg, true, false, null));
    } else if(event is SendLocalImage) {
      _list.insert(0, ChatMessage(null, true, true, event.path));
    }

//    sending update to ui
    sc.sink.add(_list);
  }

  void startMessageStream() async {
    while (isRunning) {
      print("adding new message");
      _list.insert(
          0, ChatMessage(dummyMesList[_list.length % 4], false, false, null));
      sc.sink.add(_list);
//      to add some delay between auto-generated messages
      await Future.delayed(Duration(seconds: 5));
    }
  }

  @override
  Future<void> close() {
    isRunning = false;
    sc.close();
    return super.close();
  }

  void sendMessage(String msg) {
    add(SendLocalMessage(msg));
  }

  void sendImage(String pickedFile) {
    add(SendLocalImage(pickedFile));
  }
}

class SendLocalMessage extends HttpEvent {
  String msg;

  SendLocalMessage(this.msg);
}

class SendLocalImage extends HttpEvent {
  final String path;

  SendLocalImage(this.path);
}
