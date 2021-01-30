import 'dart:convert';

Welcome formStateFromMap(String str) => Welcome.fromMap(json.decode(str));

String welcomeToMap(Welcome data) => json.encode(data.toMap());

class Welcome {
  Welcome({
    this.formationState,
  });

  FormationState formationState;

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
    formationState: FormationState.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "formationState": formationState.toMap(),
  };
}

class FormationState {
  FormationState({
    this.status,
    this.faild,
    this.success,
    this.load,
  });

  int status;
  String faild;
  String success;
  String load;

  factory FormationState.fromMap(Map<String, dynamic> json) => FormationState(
    status: json["status"],
    faild: json["faild"],
    success: json["success"],
    load: json["load"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "faild": faild,
    "success": success,
    "load": load,
  };
}
