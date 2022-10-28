import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twilio_programmable_video_example/conference/conference_page.dart';
import 'package:twilio_programmable_video_example/room/room_bloc.dart';
import 'package:twilio_programmable_video_example/room/room_model.dart';
import 'package:twilio_programmable_video_example/shared/services/backend_service.dart';

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildOptions(context),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    final backendService = Provider.of<BackendService>(context, listen: false);
    return Provider<RoomBloc>(
      create: (BuildContext context) =>
          RoomBloc(backendService: backendService),
      dispose: (BuildContext context, RoomBloc roomBloc) => roomBloc.dispose(),
      child: Consumer<RoomBloc>(builder: (context, RoomBloc roomBloc, _) {
        return FutureBuilder<RoomModel>(
          future: roomBloc.submit(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ConferencePage(roomModel: snapshot.data!);
            }
            if (snapshot.hasError) {
              // return ConferencePage(
              //   roomModel: RoomModel(
              //     identity: 'Mangi${Random().nextInt(90) + 10}',
              //     name: "MangiCon",
              //     type: TwilioRoomType.groupSmall,
              //     token:
              //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzA5YzIzN2VkZTQ0ZDQ4YmNhMzgxMWIzZGY5N2I1ZTY3LTE2NjY5NDcwNjgiLCJncmFudHMiOnsidmlkZW8iOnsicm9vbSI6IkRhaWx5In19LCJpYXQiOjE2NjY5NDcwNjgsImV4cCI6MTY2Njk1MDY2OCwiaXNzIjoiU0swOWMyMzdlZGU0NGQ0OGJjYTM4MTFiM2RmOTdiNWU2NyIsInN1YiI6IkFDYjcxNzExYzZmZWUxYWNhMzQwNDJiYmI2ZmM2MjIwODIifQ.NKsZKVMwV8R-zRD-9siUwI92iRu_vQvQQZPJKCvqVEA",
              //   ),
              // );
              return Container(
                child: Center(
                  child: Text('Error Creating Video Room, Check your internet connection'),
                ),
              );
            }
            return CircularProgressIndicator(
              color: Colors.blue,
            );
          },
        );
      }),
    );
  }
}
