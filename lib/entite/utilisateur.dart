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
    this.firstName,
    this.lastName,
    this.sexe,
    this.authorityName,
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
  String the4;
  DateTime the5;
  String the6;
  String the7;
  DateTime the8;
  DateTime the9;
  String the10;
  String the11;
  String the12;
  String firstName;
  String lastName;
  String sexe;
  String authorityName;
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
    firstName: json["first_name"],
    lastName: json["last_name"],
    sexe: json["sexe"],
    authorityName: json["authority_name"],
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
    "4": the4,
    "5": "${the5.year.toString().padLeft(4, '0')}-${the5.month.toString().padLeft(2, '0')}-${the5.day.toString().padLeft(2, '0')}",
    "6": the6,
    "7": the7,
    "8": "${the8.year.toString().padLeft(4, '0')}-${the8.month.toString().padLeft(2, '0')}-${the8.day.toString().padLeft(2, '0')}",
    "9": "${the9.year.toString().padLeft(4, '0')}-${the9.month.toString().padLeft(2, '0')}-${the9.day.toString().padLeft(2, '0')}",
    "10": the10,
    "11": the11,
    "12": the12,
    "first_name": firstName,
    "last_name": lastName,
    "sexe": sexe,
    "authority_name": authorityName,
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
