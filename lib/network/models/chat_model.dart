class ChatModel {
  final String name, lastMessage, image, time;
  final bool isActive;

  const ChatModel({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastMessage': lastMessage,
      'image': image,
      'time': time,
      'isActive': isActive,
    };
  }

  // We use the factory keyword to implement constructors
  // that do not produce new instances of an existing class.
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      image: map['image'] ?? '',
      time: map['time'] ?? '',
      isActive: map['isActive'] ?? false,
    );
  }
}
