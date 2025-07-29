class Message{
  String message;
  String id;
  Message({required this.message,required this.id});
  factory Message.fromJson(json){
    return Message(message: json['message'], id: json['id']);
  }
}