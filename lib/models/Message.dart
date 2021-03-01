class Message {
  Message({
    this.to,
    this.from,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String to;
  String from;
  String message;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        to: json["to"],
        from: json["from"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "from": from,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
