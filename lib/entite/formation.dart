/*class Formation{
  int id;
  String title;
  String description;

  Formation({this.id,this.title,this.description});
}*/

// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

Welcome listFromMap(String str) => Welcome.fromMap(json.decode(str));

String welcomeToMap(Welcome data) => json.encode(data.toMap());

class Welcome {
  Welcome({
    this.formation,
  });

  List<Formation> formation;

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
    formation: List<Formation>.from(json["data"].map((x) => Formation.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "formation": List<dynamic>.from(formation.map((x) => x.toMap())),
  };
}

class Formation {
  Formation({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.id,
    this.formationName,
    this.formationSpecialite,
    this.description,
    this.duration,
    this.startDate,
    this.endDate,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  DateTime the5;
  DateTime the6;
  String id;
  String formationName;
  String formationSpecialite;
  String description;
  String duration;
  DateTime startDate;
  DateTime endDate;

  factory Formation.fromMap(Map<String, dynamic> json) => Formation(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: DateTime.parse(json["5"]),
    the6: DateTime.parse(json["6"]),
    id: json["id"],
    formationName: json["formation_name"],
    formationSpecialite: json["formation_specialite"],
    description: json["description"],
    duration: json["duration"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
  );

  Map<String, dynamic> toMap() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": "${the5.year.toString().padLeft(4, '0')}-${the5.month.toString().padLeft(2, '0')}-${the5.day.toString().padLeft(2, '0')}",
    "6": "${the6.year.toString().padLeft(4, '0')}-${the6.month.toString().padLeft(2, '0')}-${the6.day.toString().padLeft(2, '0')}",
    "id": id,
    "formation_name": formationName,
    "formation_specialite": formationSpecialite,
    "description": description,
    "duration": duration,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
  };
}
