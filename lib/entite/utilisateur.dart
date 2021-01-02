import 'dart:convert';

Welcome userFromMap(String str) => Welcome.fromMap(json.decode(str));

String welcomeToMap(Welcome data) => json.encode(data.toMap());

class Welcome {
  Welcome({
    this.utilisateur,
  });

  List<Utilisateur> utilisateur;

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
    utilisateur: List<Utilisateur>.from(json["data"].map((x) => Utilisateur.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "utilisateur": List<dynamic>.from(utilisateur.map((x) => x.toMap())),
  };
}

class Utilisateur {
  Utilisateur({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the9,
    this.idUser,
    this.nom,
    this.prenom,
    this.sexe,
    this.dateNais,
    this.profil,
    this.etablissement,
    this.login,
    this.pwd,
    this.lastUpdate,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  DateTime the4;
  String the5;
  String the6;
  String the7;
  String the8;
  DateTime the9;
  String idUser;
  String nom;
  String prenom;
  String sexe;
  DateTime dateNais;
  String profil;
  String etablissement;
  String login;
  String pwd;
  DateTime lastUpdate;

  factory Utilisateur.fromMap(Map<String, dynamic> json) => Utilisateur(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: DateTime.parse(json["4"]),
    the5: json["5"],
    the6: json["6"],
    the7: json["7"],
    the8: json["8"],
    the9: DateTime.parse(json["9"]),
    idUser: json["id_user"],
    nom: json["nom"],
    prenom: json["prenom"],
    sexe: json["sexe"],
    dateNais: DateTime.parse(json["date_nais"]),
    profil: json["profil"],
    etablissement: json["etablissement"],
    login: json["login"],
    pwd: json["pwd"],
    lastUpdate: DateTime.parse(json["last_update"]),
  );

  Map<String, dynamic> toMap() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": "${the4.year.toString().padLeft(4, '0')}-${the4.month.toString().padLeft(2, '0')}-${the4.day.toString().padLeft(2, '0')}",
    "5": the5,
    "6": the6,
    "7": the7,
    "8": the8,
    "9": the9.toIso8601String(),
    "id_user": idUser,
    "nom": nom,
    "prenom": prenom,
    "sexe": sexe,
    "date_nais": "${dateNais.year.toString().padLeft(4, '0')}-${dateNais.month.toString().padLeft(2, '0')}-${dateNais.day.toString().padLeft(2, '0')}",
    "profil": profil,
    "etablissement": etablissement,
    "login": login,
    "pwd": pwd,
    "last_update": lastUpdate.toIso8601String(),
  };
}
