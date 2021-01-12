import 'dart:convert';

Welcome welcomeFromMap(String str) => Welcome.fromMap(json.decode(str));

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
    this.the10,
    this.the11,
    this.firstName,
    this.lastName,
    this.sexe,
    this.civilite,
    this.dateOfBird,
    this.matricule,
    this.numeroCni,
    this.dateDelivrance,
    this.dateExpiration,
    this.nomEtablissement,
    this.email,
    this.phoneNumber,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  DateTime the4;
  String the5;
  String the6;
  DateTime the7;
  DateTime the8;
  String the9;
  String the10;
  String the11;
  String firstName;
  String lastName;
  String sexe;
  String civilite;
  DateTime dateOfBird;
  String matricule;
  String numeroCni;
  DateTime dateDelivrance;
  DateTime dateExpiration;
  String nomEtablissement;
  String email;
  String phoneNumber;

  factory Utilisateur.fromMap(Map<String, dynamic> json) => Utilisateur(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: DateTime.parse(json["4"]),
    the5: json["5"],
    the6: json["6"],
    the7: DateTime.parse(json["7"]),
    the8: DateTime.parse(json["8"]),
    the9: json["9"],
    the10: json["10"],
    the11: json["11"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    sexe: json["sexe"],
    civilite: json["civilite"],
    dateOfBird: DateTime.parse(json["date_of_bird"]),
    matricule: json["matricule"],
    numeroCni: json["numero_cni"],
    dateDelivrance: DateTime.parse(json["date_delivrance"]),
    dateExpiration: DateTime.parse(json["date_expiration"]),
    nomEtablissement: json["nom_etablissement"],
    email: json["email"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toMap() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": "${the4.year.toString().padLeft(4, '0')}-${the4.month.toString().padLeft(2, '0')}-${the4.day.toString().padLeft(2, '0')}",
    "5": the5,
    "6": the6,
    "7": "${the7.year.toString().padLeft(4, '0')}-${the7.month.toString().padLeft(2, '0')}-${the7.day.toString().padLeft(2, '0')}",
    "8": "${the8.year.toString().padLeft(4, '0')}-${the8.month.toString().padLeft(2, '0')}-${the8.day.toString().padLeft(2, '0')}",
    "9": the9,
    "10": the10,
    "11": the11,
    "first_name": firstName,
    "last_name": lastName,
    "sexe": sexe,
    "civilite": civilite,
    "date_of_bird": "${dateOfBird.year.toString().padLeft(4, '0')}-${dateOfBird.month.toString().padLeft(2, '0')}-${dateOfBird.day.toString().padLeft(2, '0')}",
    "matricule": matricule,
    "numero_cni": numeroCni,
    "date_delivrance": "${dateDelivrance.year.toString().padLeft(4, '0')}-${dateDelivrance.month.toString().padLeft(2, '0')}-${dateDelivrance.day.toString().padLeft(2, '0')}",
    "date_expiration": "${dateExpiration.year.toString().padLeft(4, '0')}-${dateExpiration.month.toString().padLeft(2, '0')}-${dateExpiration.day.toString().padLeft(2, '0')}",
    "nom_etablissement": nomEtablissement,
    "email": email,
    "phone_number": phoneNumber,
  };
}
