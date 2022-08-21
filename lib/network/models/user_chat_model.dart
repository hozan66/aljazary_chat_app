import 'package:equatable/equatable.dart';

class UserChatModel extends Equatable {
  late final String status;
  late final List<UserChatDataModel> dataModel;

  UserChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['data'].forEach((element) {
      dataModel.add(UserChatDataModel.fromJson(element));
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': dataModel.map((x) => x.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [status, dataModel];
}

class UserChatDataModel extends Equatable {
  late final String room;
  late final String sender;
  late final String message;
  late final String messageType;
  late final List<dynamic> see;
  late final String time;
  late final String id;

  UserChatDataModel({
    required this.room,
    required this.sender,
    required this.message,
    required this.messageType,
    this.see = const [],
    this.time = '12:16',
    this.id = 'id',
  });

  UserChatDataModel.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    sender = json['author'];
    message = json['message'];
    messageType = json['messageType'];
    see = json['see'] ?? [];
    time = json['time'] ?? '12:16';
    id = json['_id'] ?? 'id';
  }

  Map<String, dynamic> toJson() {
    return {
      'room': room,
      'author': sender,
      'message': message,
      'messageType': messageType,
      'see': see,
      'time': time,
      '_id': id,
    };
  }

  @override
  List<Object?> get props => [
        room,
        sender,
        message,
        messageType,
        see,
        time,
        id,
      ];

  UserChatDataModel copyWith({
    final String? room,
    final String? sender,
    final String? message,
    final String? messageType,
    final List<dynamic>? see,
    final String? time,
    final String? id,
  }) {
    return UserChatDataModel(
      room: room ?? this.room,
      sender: sender ?? this.sender,
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
      see: see ?? this.see,
      time: time ?? this.time,
      id: id ?? this.id,
    );
  }
}
