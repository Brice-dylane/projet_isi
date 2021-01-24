import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projet_isi/entite/formation.dart';
import 'package:projet_isi/entite/utilisateur.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import '../constants.dart';

// ignore: must_be_immutable
class Candidacy extends StatelessWidget{
  Formation formation;
  Utilisateur user;
  Candidacy(Formation formation,Utilisateur user){
    this.formation = formation;
    this.user = user;
  }

  File selectedfile;
  Response response;
  String progress;
  Dio dio = new Dio();

  void selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if(result != null) {
      selectedfile = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formation.formationName.toUpperCase()),
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer(){
    return Container(
      child: ListView(
        children: <Widget>[
              Card(
                elevation: 10.0,
                margin: EdgeInsets.only(top: 20.0,left: 20.0, right: 20.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text('Spécialité', style: TextStyle(color: mainColor,fontSize: 25), textAlign: TextAlign.left,),
                    Text(formation.formationSpecialite, style: TextStyle(color:mainColor,fontSize: 17.0))
                  ],
                ),
              ),

              Card(
                elevation: 10.0,
                margin: EdgeInsets.only(top: 20.0,left: 20.0, right: 20.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text('Durée', style: TextStyle(color: mainColor,fontSize: 25)),
                    Text("Du "+formation.startDate.day.toString()+"-"+formation.startDate.month.toString()+"-"+formation.startDate.year.toString()+" au "+formation.endDate.day.toString()+"-"+formation.endDate.month.toString()+"-"+formation.endDate.year.toString(), style: TextStyle(color: mainColor))
                  ],
                ),
              ),

              Card(
                elevation: 10.0,
                margin: EdgeInsets.only(top: 20.0,left: 20.0, right: 20.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text('Description', style: TextStyle(color: mainColor,fontSize: 25)),
                    Text(formation.description, style: TextStyle(color: mainColor))
                  ],
                ),
              ),

          Container(margin: EdgeInsets.all(20),),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            //show file name here
            child:selectedfile == null?
            Text("Sélectioner un fichier"):
            Text(basename(selectedfile.path)),
          ),

          Container(
              margin: EdgeInsets.only(left: 190.0, right: 190.0),
              child:RaisedButton.icon(
                onPressed: (){
                  selectFile();
                },
                icon: Icon(Icons.folder_open),
                label: Text('Joindre un fichier'),
                color: Colors.redAccent,
                colorBrightness: Brightness.dark,
              )
          ),

          Container(margin: EdgeInsets.all(20),),

          Container(
              margin: EdgeInsets.only(left: 150.0, right: 150.0),
              child:RaisedButton.icon(padding: EdgeInsets.all(20),
                onPressed: (){
                  selectFile();
                },
                icon: Icon(Icons.badge),
                label: Text(user.getProfil()=='ROLE_PROF'? 'Former':'Se former',style: TextStyle(fontSize: 33),),
                color: mainColor,
                colorBrightness: Brightness.dark,
              )
          )
        ],
      ),
    );
  }

}
