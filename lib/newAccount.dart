import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet_isi/api_manager.dart';
import 'package:projet_isi/entite/insertUser.dart';
import 'package:select_form_field/select_form_field.dart';
import 'constants.dart';
import 'entite/utilisateur.dart';
import 'package:email_validator/email_validator.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

// ignore: must_be_immutable
class CreateAccountPage extends StatefulWidget{
  @override
  _CreateAccountPage createState() => _CreateAccountPage();
}

class _CreateAccountPage extends State<CreateAccountPage> {
  String mdp='';
  String confirMDP='';
  DateTime _date = DateTime.now();
  DateTime update = DateTime.now();
  int jour = DateTime.now().day;
  int mois = DateTime.now().month;
  int annee = DateTime.now().year;

  String nom = '';
  String prenom = '';
  String sexe = '';
  String profile = '';
  String etablissement = '';
  String login = '';


  final _formKey = GlobalKey<FormState>();

  Future<Null> selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context:context,
      initialDate:_date,
      firstDate: DateTime(1945),
      lastDate: DateTime(2100),
    );
    if(picked!=null && picked!=_date){
      setState(() {
        _date = picked;
        jour = _date.day;
        mois = _date.month;
        annee = _date.year;
      });
    }
  }

  final List<Map<String, dynamic>> _sexitems = [
    {
      'value': 'Femme',
      'label': 'Femme',
      'icon': Icon(Icons.accessibility),
    },
    {
      'value': 'Homme',
      'label': 'Homme',
      'icon': Icon(Icons.accessibility),
    },
  ];

  final List<Map<String, dynamic>> _profilitems = [
    {
      'value': 'Professeur',
      'label': 'Professeur',
      'icon': Icon(Icons.emoji_people),
    },
    {
      'value': 'Etudiant',
      'label': 'Etudiant',
      'icon': Icon(Icons.emoji_people_rounded),
    },
    {
      'value': 'Eleve',
      'label': 'Eleve',
      'icon': Icon(Icons.emoji_people_rounded),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Apply to ISJ - Créer un compte'),
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer(){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0, bottom: 20.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildTitleRow(),
                _buildNomRow(),
                _buildPrenomRow(),
                _buildSexeRow(),
                _buildDateNaissRow(),
                _buildProfilRow(),
                _buildEtablissementRow(),
                _buildMailRow(),
                _buildMDPRow(),
                _buildConfirmMDPRow(),
                _buildCreateBtnRow()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow(){
    return Row(
      children: <Widget>[
        Icon(Icons.account_circle, color: mainColor,size: 80.0),
        new Text(' Nouveau compte', style: TextStyle(fontSize: 35.0),)
      ],
    );
  }

  Widget _buildNomRow() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (String change){
                  setState(() {
                    nom = change;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom',
                ),
                validator: (val) => val.isEmpty ? 'Entrer votre nom': null,
              )
            ],
          )
      )
    );
  }

  Widget _buildPrenomRow() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (String change){
                    setState(() {
                      prenom = change;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prénom',
                  ),
                  validator: (val) => val.isEmpty? 'Entrer votre prénom': null,
                )
              ],
            )
        )
    );
  }

  Widget _buildSexeRow(){
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: SelectFormField(
        type: SelectFormFieldType.dropdown, // or can be dialog
        initialValue: 'circle',
        labelText: 'Sex',
        items: _sexitems,
        onChanged: (String change) {
          setState(() {
            sexe = change;
          });
        },
        onSaved: (val) => print(val),
      ),
    );
  }

  Widget _buildDateNaissRow() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[

            Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.calendar_today_sharp), onPressed: () => selectDate(context)),
                Text('Date de naissance: ',style: TextStyle(fontSize: 20.0),),
                Text(jour.toString(),style: TextStyle(fontSize: 20.0)),
                Text('/', style: TextStyle(fontSize: 20.0)),
                Text(mois.toString(), style: TextStyle(fontSize: 20.0)),
                Text('/', style: TextStyle(fontSize: 20.0)),
                Text(annee.toString(), style: TextStyle(fontSize: 20.0)),
              ],
            ),
          ],
        ),
    );
  }


  Widget _buildProfilRow(){
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: SelectFormField(
        type: SelectFormFieldType.dropdown, // or can be dialog
        initialValue: 'circle',
        labelText: 'Profil',
        items: _profilitems,
        onChanged: (String change){
          setState(() {
            profile = change;
          });
        },
        onSaved: (val) => print(val),
      ),
    );
  }

  Widget _buildEtablissementRow() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (String change){
                    setState(() {
                      etablissement = change;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Etablissement',
                  ),
                  validator: (val) => val.isEmpty? 'Entrer votre établissement':null,
                )
              ],
            )
        )
    );
  }

  Widget _buildMailRow() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (String change){
                    setState(() {
                      login = change;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (val) => !EmailValidator.Validate(login,true)? 'Adresse mail non valide':null,
                )
              ],
            )
        )
    );
  }

  Widget _buildMDPRow() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: (String change){
                    setState(() {
                      mdp = convertMdp(change);
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mot de passe',
                  ),
                  validator: (val) => mdp.length<=6? 'Entrez un mot de passe avec au moins 6 caractères':null,
                )
              ],
            )
        )
    );
  }

  Widget _buildConfirmMDPRow() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: (String change){
                    setState(() {
                      confirMDP = convertMdp(change);
                      mdp = confirMDP;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmer le mot de passe',
                  ),
                  validator: (val) => confirMDP != mdp ? 'Le mot de passe ne correspond pas':null,
                )
              ],
            )
        )
    );
  }

  Widget _buildCreateBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 8),
          margin: EdgeInsets.only(bottom: 20,top: 15.0),
          child: RaisedButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () async {
              if(_formKey.currentState.validate()){
                Utilisateur newUser = new Utilisateur(
                  nom: nom,
                  prenom: prenom,
                  sexe: sexe,
                  dateNais: _date,
                  profil: profile,
                  etablissement: etablissement,
                  login: login,
                  pwd: mdp,
                  lastUpdate: update,
                );
                Data dataCreate = await newAccount(newUser);
                print(dataCreate.message);
                if(dataCreate.status==1) {
                  dialog("Success!", "Votre compte a été créé",dataCreate.status);
                }
                else{
                  dialog("Echec!", "L'adresse mail est déja utilisée",dataCreate.status);
                }
              }
            },
            child: Text(
              "Créer mon compte",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }


  String convertMdp(String mdp){
    var content = new Utf8Encoder().convert(mdp);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }


  Future<Null> dialog(String title, String desc, int status) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return new SimpleDialog(
            title: new Text(title, textScaleFactor: 1.4, style: TextStyle(color: status==1?Colors.green:Colors.redAccent),),
            contentPadding: EdgeInsets.all(10.0),
            children: <Widget> [
              new Text(desc, style: TextStyle(color: status==1?Colors.green:Colors.redAccent)),
              new Container(height: 20.0,),
              new RaisedButton(
                color: Colors.teal,
                textColor: Colors.white,
                child: new Text('OK'),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

}