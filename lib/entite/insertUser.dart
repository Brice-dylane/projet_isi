import 'dart:convert';

Welcome insertFromMap(String str) => Welcome.fromMap(json.decode(str));

String welcomeToMap(Welcome data) => json.encode(data.toMap());

class Welcome {
  Welcome({
    this.data,
  });

  Data data;

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data.toMap(),
  };
}

class Data {
  Data({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
  };
}
