import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utilisateur {
  String nom;
  String prenom;
  String sexe;
  DateTime dateNais;
  String profil;
  String etablissement;
  String mail;
  String mdp;

  Utilisateur(String nom,String prenom,String sexe,DateTime dateNais,String profil,String etablissement,String mail,String mdp){
    this.nom = nom;
    this.prenom = prenom;
    this.sexe = sexe;
    this.dateNais = dateNais;
    this.profil = profil;
    this.etablissement = etablissement;
    this.mail = mail;
    this.mdp = mdp;
  }

  String toString(){
    return "Utilisateur [nom="+nom+" , Prenom="+prenom+", Sexe="+sexe+", DateNais="+dateNais.toString()+", "
        "Profil="+profil+", Etablissement="+etablissement+", Mail="+mail+"]";
  }
}

class User {
  String login;
  String mdp;

  User(String login, String mdp){
    this.login = login;
    this.mdp = mdp;
  }

}