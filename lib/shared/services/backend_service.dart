// import 'package:cloud_functions/cloud_functions.dart';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:twilio_programmable_video_example/models/twilio_room_by_sid_request.dart';
import 'package:twilio_programmable_video_example/models/twilio_room_request.dart';
import 'package:twilio_programmable_video_example/models/twilio_room_response.dart';
import 'package:twilio_programmable_video_example/models/twilio_room_token_request.dart';
import 'package:twilio_programmable_video_example/models/twilio_room_token_response.dart';

abstract class BackendService {
  Future<TwilioRoomResponse> completeRoomBySid(
      TwilioRoomBySidRequest twilioRoomBySidRequest);
  Future<TwilioRoomResponse> createRoom(TwilioRoomRequest twilioRoomRequest);
  Future<TwilioRoomTokenResponse> createToken(
      TwilioRoomTokenRequest twilioRoomTokenRequest);
}

class FirebaseFunctionsService implements BackendService {
  FirebaseFunctionsService._();

  static final instance = FirebaseFunctionsService._();

  final FirebaseFunctions cf =
      FirebaseFunctions.instanceFor(region: 'europe-west1');

  @override
  Future<TwilioRoomResponse> completeRoomBySid(
      TwilioRoomBySidRequest twilioRoomBySidRequest) async {
    try {
      final response = await cf
          .httpsCallable('completeRoomBySid')
          .call(twilioRoomBySidRequest.toMap());
      return TwilioRoomResponse.fromMap(
          Map<String, dynamic>.from(response.data));
    } on FirebaseFunctionsException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
        details: e.details,
      );
    }
  }

  @override
  Future<TwilioRoomResponse> createRoom(
      TwilioRoomRequest twilioRoomRequest) async {
    try {
      final response =
          await cf.httpsCallable('createRoom').call(twilioRoomRequest.toMap());

      return TwilioRoomResponse.fromMap(
          Map<String, dynamic>.from(response.data));
    } on FirebaseFunctionsException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
        details: e.details,
      );
    }
  }

  @override
  Future<TwilioRoomTokenResponse> createToken(
      TwilioRoomTokenRequest twilioRoomTokenRequest) async {
    try {
      final response = await cf
          .httpsCallable('createToken')
          .call(twilioRoomTokenRequest.toMap());

      return TwilioRoomTokenResponse.fromMap(
          Map<String, dynamic>.from(response.data));
    } on FirebaseFunctionsException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
        details: e.details,
      );
    }
  }
}
