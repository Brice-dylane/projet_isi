// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

Welcome listFormationUserFromMap(String str) => Welcome.fromMap(json.decode(str));

String welcomeToMap(Welcome data) => json.encode(data.toMap());

class Welcome {
  Welcome({
    this.formationUser,
  });

  List<FormationUser> formationUser;

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
    formationUser: List<FormationUser>.from(json["data"].map((x) => FormationUser.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "FormationUser": List<dynamic>.from(formationUser.map((x) => x.toMap())),
  };
}

class FormationUser {
  FormationUser({
    this.formationName,
    this.formationSpecialite,
    this.description,
    this.duration,
    this.startDate,
    this.endDate,
    this.createTime,
    this.candidacyState,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  DateTime the5;
  DateTime the6;
  DateTime the7;
  String the8;
  String id;
  String formationName;
  String formationSpecialite;
  String description;
  String duration;
  DateTime startDate;
  DateTime endDate;
  DateTime createTime;
  String candidacyState;

  factory FormationUser.fromMap(Map<String, dynamic> json) => FormationUser(
    formationName: json["formation_name"],
    formationSpecialite: json["formation_specialite"],
    description: json["description"],
    duration: json["duration"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    createTime: DateTime.parse(json["create_time"]),
    candidacyState: json["candidacy_state"],
  );

  Map<String, dynamic> toMap() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": "${the5.year.toString().padLeft(4, '0')}-${the5.month.toString().padLeft(2, '0')}-${the5.day.toString().padLeft(2, '0')}",
    "6": "${the6.year.toString().padLeft(4, '0')}-${the6.month.toString().padLeft(2, '0')}-${the6.day.toString().padLeft(2, '0')}",
    "7": the7.toIso8601String(),
    "8": the8,
    "id": id,
    "formation_name": formationName,
    "formation_specialite": formationSpecialite,
    "description": description,
    "duration": duration,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "create_time": createTime.toIso8601String(),
    "candidacy_state": candidacyState,
  };
}
