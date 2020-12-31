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

List<Formation> formationFromMap(String str) => List<Formation>.from(json.decode(str).map((x) => Formation.fromMap(x)));

String formationToMap(Welcome data) => json.encode(data.toMap());

class Welcome {
  Welcome({
    this.formation,
  });

  List<Formation> formation;

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
    formation: List<Formation>.from(json["formation"].map((x) => Formation.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "formation": List<dynamic>.from(formation.map((x) => x.toMap())),
  };
}

class Formation {
  Formation({
    this.id,
    this.titre,
    this.description,
  });

  String id;
  String titre;
  String description;

  factory Formation.fromMap(Map<String, dynamic> json) => Formation(
    id: json["id"],
    titre: json["titre"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "titre": titre,
    "description": description,
  };
}
