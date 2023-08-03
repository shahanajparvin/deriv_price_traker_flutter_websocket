import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../utils/constants.dart';

class WebSocketChannelService {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  void connectWs() {
    _channel = WebSocketChannel.connect(Uri.parse("${Constants.SERVER_URL}?app_id=${Constants.API_ID}"));
  }

  void registerWebSocketListeners({Function(dynamic)? onData, Function(dynamic)? onError, Function(void)? onDone}) {
    if (_subscription != null) {
      _subscription?.cancel();
    }
    _subscription = _channel?.stream.listen((data) {
      if (onData != null) {
        onData(data);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    }, onDone: () {
      if (onDone != null) {
        onDone(null);
      }
    });
  }

  void transmitWebSocketMessage(Map<String, dynamic> message) {
    _channel?.sink.add(jsonEncode(message));
  }

  void closeWebSocketConnection() {
    _subscription?.cancel();
    _channel?.sink.close();
  }

  bool get isConnected => _channel?.sink?.done == null;
}