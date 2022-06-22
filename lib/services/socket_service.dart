import 'package:flutter/cupertino.dart';
import 'package:riderhub/utils/params.dart';
import 'package:socket_io_client/socket_io_client.dart';

// const String SOCKET = 'ws://143.198.4.186:8000/faye';
const String SOCKET = 'https://pubsub.tasleem.in/?token=iC_s7xcGe91UUHvyNl48';
// const String SOCKET = 'ws://54.36.110.237:8222';

class SocketService {
  Socket socket;

  createSocketConnection() {
    socket = io(
      SOCKET,
      OptionBuilder().setTransports(['websocket']).build(),
    );
    socket.connect();

    socket.onConnect((_) async {
      print('[socket] connected');
    });

    socket.onConnectError((data) {
      print('[socket] error: ${data.toString()}');
    });

    this.socket.on("disconnect", (_) => print('Disconnected'));
  }

  void addStatusListener({
    @required Function(dynamic) hotspot,
    @required Function(dynamic) driverSchedule,
  }) {
    this.socket.on("/hotspot/${Params.currentUser.regional_zone_id}",
        (value) async {
      print(
          "[socket] /hotspot/${Params.currentUser.regional_zone_id} ===> ${value.toString()}");
      hotspot(value);
    });

    this.socket.on("/driver_schedule/${Params.currentUser.id}",
        (value) async {
      print(
          "[socket] /driver_schedule/${Params.currentUser.id} ===> ${value.toString()}");
      driverSchedule(value);
    });
  }
}
