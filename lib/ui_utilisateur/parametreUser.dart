import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:projet_isi/entite/insertUser.dart';
import 'package:projet_isi/entite/utilisateur.dart';
import 'package:select_form_field/select_form_field.dart';

import 'package:email_validator/email_validator.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:projet_isi/api_manager.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class Parametre extends StatefulWidget{
@override
_Parametre createState() => _Parametre();
}

class _Parametre extends State<Parametre>{

  Utilisateur user;
  String mdp='';
  String confirMDP='';
  DateTime _date = DateTime.now();
  DateTime update = DateTime.now();
  int jour = DateTime.now().day;
  int mois = DateTime.now().month;
  int annee = DateTime.now().year;

  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  InputType inputType = InputType.date;
  //Utilisateur utilisateur= FlutterSession().get('token') as Utilisateur;

  ProgressDialog progressDialog;
  String nom = '';
  String prenom = '';
  String sexe = '';
  String profile = '';
  String etablissement = '';
  String login = '';
  String civilite = '';
  String matricule = '';
  String cni = '';
  String telephone = '';


  DateTime dateNais;
  DateTime dateDelivrance;
  DateTime dateExpiration;


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

  final List<Map<String, dynamic>> _civilitetems = [
    {
      'value': 'M',
      'label': 'M',
    },
    {
      'value': 'Mme',
      'label': 'Mme',
    },
    {
      'value': 'Mlle',
      'label': 'Mlle',
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer(){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0, bottom: 20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Center(
                child: FutureBuilder(
                  future: FlutterSession().get('token'),
                  builder: (context,snapshot){
                    String logi = snapshot.data;
                    return FutureBuilder<Utilisateur>(
                      future: userInfo(logi),
                      initialData: user,
                      builder: (context,AsyncSnapshot<Utilisateur> snapshot1){
                        if(snapshot1.hasData){
                          user = snapshot1.data;
                          if(user.getProfil()=='ROLE_PROF'){
                            profile = 'Professeur';
                          }
                          else if(user.getProfil()=='ROLE_ETUDIANT'){
                            profile = 'Etudiant';
                          }
                          else{
                            profile = 'Eleve';
                          }
                          return Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                _buildTitleRow(user.getProfil()),
                                _buildNomRow(user.getFirstName()),
                                _buildPrenomRow(user.getLastName()),
                                _sexAndProfil(user.getSexe(), user.getCni()),
                                _buildDateNaissRow(user.getDateNais()),
                                _buildMatriculeRow(user.getMatricule(),user.getProfil()),
                                _buildCNIRow(user.getCni()),
                                _buildDelivranceRow(user.getDelivrance()),
                                _buildExpirationRow(user.getExpire()),
                                _buildEtablissementRow(user.getEtablissement(),user.getProfil()),
                                _buildMailRow(user.getEmail()),
                                _buildTelRow(user.getTel()),
                                _buildMDPRow(),
                                _buildConfirmMDPRow(),
                                _buildCreateBtnRow(user)
                              ],
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow(String profil){
    return Row(
      children: <Widget>[
        Icon(Icons.account_circle, color: mainColor,size: 80.0),
        // ignore: unrelated_type_equality_checks
        new Text(profil=='ROLE_ETUDIANT'?'Etudiant': '', style: TextStyle(fontSize: 30.0),),
        new Text(profil=='ROLE_PROF'?'Professeur': '', style: TextStyle(fontSize: 30.0),),
        new Text(profil=='ROLE_ELEVE'?'Elève':'', style: TextStyle(fontSize: 30.0),)
      ],
    );
  }

  Widget _buildNomRow(String name) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                 //initialValue: name,
                  keyboardType: TextInputType.text,
                  onChanged: (String change){
                    setState(() {
                      nom = change;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom*: '+name,
                  ),
                  //validator: (val) => val.isEmpty ? 'Entrer votre nom': null,
                )
              ],
            )
        )
    );
  }

  Widget _buildPrenomRow(String prename) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                 //initialValue: prename,
                  keyboardType: TextInputType.text,
                  onChanged: (String change){
                    setState(() {
                      prenom = change;
                      print(prenom);
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prénom*: '+prename,
                  ),
                 // validator: (val) => prenom.isEmpty? 'Entrer votre prénom': null,
                )
              ],
            )
        )
    );
  }

  Widget _buildSexeRow(String s){
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: SelectFormField(
        type: SelectFormFieldType.dropdown, // or can be dialog
        labelText: 'Sexe*: '+s,
        style: TextStyle(fontSize: 15),
        items: _sexitems,
        onChanged: (String change) {
          setState(() {
            sexe = change;
          });
        },
       // validator: (val) => sexe.isEmpty? 'Entrer votre sexe': null,
        onSaved: (val) => print(val),
      ),
    );
  }

  Widget _buildcivilite(String c){
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      width: 450.0,
      child: SelectFormField(
        type: SelectFormFieldType.dropdown, // or can be dialog
        labelText: 'Civilité*: '+c,
        style: TextStyle(fontSize: 15),
        items: _civilitetems,
        onChanged: (String change) {
          setState(() {
            civilite = change;
          });
        },
        //validator: (val) => civilite.isEmpty? 'Entrer votre civilité': null,
        onSaved: (val) => print(val),
      ),
    );
  }


  Widget _sexAndProfil(String sex, String ci){
    return Row(
      children: <Widget>[
        Container(
          width: 125.0,
          child: _buildSexeRow(sex),
        ),
        Container(
          width: 125.0,
          child: _buildcivilite(ci),
        )
      ],
    );
  }

  Widget _buildDateNaissRow(DateTime nais) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          DateTimePickerFormField(
            //validator: (val) => val==null? 'Entrer votre date de naissance': null,
            inputType: inputType,
            initialDate: nais,
            format: formats[inputType],
            editable: true,
            decoration: InputDecoration(
                labelText: 'Date de naissance*: '+nais.toString(), border: OutlineInputBorder()),
            onChanged: (DateTime datetime){
              setState(() {
                dateNais  = datetime;
              });
            },
          )
        ],
      ),
    );
  }


  Widget _buildMatriculeRow(String matricul,String profil) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  readOnly: profil=='ROLE_PROF'? true : false,
                  keyboardType: TextInputType.text,
                  onChanged: (String change){
                    setState(() {
                      matricule = change;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Matricule scolaire ISJ: '+matricul,
                  ),
                )
              ],
            )
        )
    );
  }

  Widget _buildCNIRow(String num_cni) {
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
                      cni = change;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Numéro CNI*: '+num_cni,
                  ),
                  //validator: (val) => val.isEmpty ? 'Entrer votre numero de CNI': null,
                )
              ],
            )
        )
    );
  }


  Widget _buildDelivranceRow(DateTime de) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          DateTimePickerFormField(
            //validator: (val) => val==null? 'Entrer votre date de délivrance': null,
            inputType: inputType,
            initialDate: de,
            format: formats[inputType],
            editable: true,
            decoration: InputDecoration(
                labelText: "Date de délivrance*: "+de.toString(), border: OutlineInputBorder()),
            onChanged: (DateTime datetime){
              setState(() {
                dateDelivrance  = datetime;
              });
            },
          )
        ],
      ),
    );
  }


  Widget _buildExpirationRow(DateTime ex) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          DateTimePickerFormField(
            //validator: (val) => val==null? "Entrer votre date d'expiration": null,
            inputType: inputType,
            initialDate: ex,
            format: formats[inputType],
            editable: true,
            decoration: InputDecoration(
                labelText: "Date d'expiration*: "+ex.toString(), border: OutlineInputBorder()),
            onChanged: (DateTime datetime){
              setState(() {
                dateExpiration  = datetime;
              });
            },
          )
        ],
      ),
    );
  }


  Widget _buildEtablissementRow(String etabli, String profil) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(readOnly: profil=='ROLE_PROF'? true : false,
                  //initialValue: etabli,
                  keyboardType: TextInputType.text,
                  onChanged: (String change){
                    setState(() {
                      etablissement = change;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Etablissement: '+etabli,
                  ),
                )
              ],
            )
        )
    );
  }


  Widget _buildMailRow(String mail) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  onChanged: (String change){
                    setState(() {
                      login = change;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email*: '+mail,
                  ),
                )
              ],
            )
        )
    );
  }

  Widget _buildTelRow(String tel) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.phone,
                  onChanged: (String change){
                    setState(() {
                      telephone = change;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Téléphone*: '+tel,
                  ),
                  //validator: (val) => val.isEmpty? 'Entrer votre téléphone':null,
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
                    labelText: 'Mot de passe*',
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
                    labelText: 'Confirmer le mot de passe*',
                  ),
                  validator: (val) => confirMDP != mdp ? 'Le mot de passe ne correspond pas':null,
                )
              ],
            )
        )
    );
  }

  Widget _buildCreateBtnRow(Utilisateur utilisateur) {
    progressDialog = ProgressDialog(context, type:ProgressDialogType.Normal);
    progressDialog.style(
        message: 'Mise à jour en cours...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
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
                Utilisateur user = new Utilisateur(
                    firstName: nom==''? utilisateur.getFirstName() : nom,
                    lastName: prenom==''? utilisateur.getLastName():prenom,
                    sexe: sexe==''? utilisateur.getSexe():sexe,
                    authorityName: utilisateur.getProfil(),
                    civilite: civilite==''? utilisateur.getCivilite():civilite,
                    dateOfBird: dateNais==null ? utilisateur.getDateNais():dateNais,
                    matricule: matricule==''? utilisateur.getMatricule(): matricule,
                    numeroCni: cni==''? utilisateur.getSexe():cni,
                    dateDelivrance: dateDelivrance==null? utilisateur.getDelivrance():dateDelivrance,
                    dateExpiration: dateExpiration==null ? utilisateur.getExpire(): dateExpiration,
                    nomEtablissement: etablissement==''? utilisateur.getEtablissement():etablissement,
                    email: login==''? utilisateur.getEmail():login,
                    phoneNumber: telephone==''? utilisateur.getTel():telephone
                );
                progressDialog.show();
                Data dataCreate = await updateUser(user,update,confirMDP);
                print(prenom);
                print(etablissement);
                if(dataCreate.status==1) {
                  progressDialog.hide();
                  dialog("Success!", "Votre compte a été mis à jour",dataCreate.status);
                  String t = await FlutterSession().get('token');
                  setState(() {
                    userInfo(t);
                  });
                }
                else{
                  progressDialog.hide();
                  dialog("Echec!", "Echec de la mise à jour",dataCreate.status);
                }
              }
            },
            child: Text(
              "Mettre à jour",
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

  Future<Utilisateur> userInfo(String login) async{
    Utilisateur user = await fetchUser(login);
    return user;
  }


}