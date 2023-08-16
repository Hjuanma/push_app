import 'package:isar/isar.dart';

part 'push_message.g.dart';

@collection
class PushMessage {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  final String messageId;
  final String title;
  final String body;
  final DateTime sentDate;
  @ignore
  final Map<String, dynamic>? data;
  final String? imageUrl;

  PushMessage(
      {required this.messageId,
      required this.title,
      required this.body,
      required this.sentDate,
      this.data,
      this.imageUrl});

  @override
  String toString() {
    return '''
      PushMessge
      id:       $messageId
      title:    $title
      body:     $body
      sentDate: $sentDate
      data:     $data
      imageUrl: $imageUrl''';
  }
}
