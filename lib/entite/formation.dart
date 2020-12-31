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

Welcome welcomeFromMap(String str) => Welcome.fromMap(json.decode(str));

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
    this.id,
    this.titre,
    this.description,
  });

  String the0;
  String the1;
  String the2;
  String id;
  String titre;
  String description;

  factory Formation.fromMap(Map<String, dynamic> json) => Formation(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    id: json["id"],
    titre: json["titre"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "id": id,
    "titre": titre,
    "description": description,
  };
}
