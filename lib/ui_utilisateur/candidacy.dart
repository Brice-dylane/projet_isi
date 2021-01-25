import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:projet_isi/entite/formation.dart';
import 'package:projet_isi/entite/utilisateur.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';



class Candidacy extends StatefulWidget{
  static Formation formation;
  static Utilisateur user;
  Candidacy(Formation formation1,Utilisateur user1){
    formation = formation1;
    user = user1;
  }
  @override
  State<StatefulWidget> createState() {
    return _Candidacy();
  }
}


class _Candidacy extends State<Candidacy>{
  File selectedfile;
  Response response;
  String progress;
  Dio dio = new Dio();
  String fileName = '';
  bool isEnable = true;
  ProgressDialog progressDialog;

  void selectFile() async {
    selectedfile = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['zip', 'pdf', 'docx'],
      //allowed extension to choose
    );
    setState(() {
      fileName = basename(selectedfile.path);
    });
  }


  uploadFile() async {
    var random = new Random();
    String code = Candidacy.formation.formationName.substring(0,3).toUpperCase()+""+Candidacy.formation.formationSpecialite.substring(0,3).toUpperCase()+""+Candidacy.formation.startDate.year.toString()+""+random.nextInt(10000).toString();
    final uri = Uri.parse("http://192.168.1.104/webservice/candidacy.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['created'] = DateTime.now().toString();
    request.fields['email'] = Candidacy.user.getEmail();
    request.fields['formation'] = Candidacy.formation.formationName;
    request.fields['code'] = code;
    var pic = await http.MultipartFile.fromPath("file", selectedfile.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        isEnable = false;
      });
      print('File Uploded');
    }else{
      print('File Not Uploded');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Candidacy.formation.formationName.toUpperCase()),
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
                Text(Candidacy.formation.formationSpecialite, style: TextStyle(color:mainColor,fontSize: 17.0))
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
                Text("Du "+Candidacy.formation.startDate.day.toString()+"-"+Candidacy.formation.startDate.month.toString()+"-"+Candidacy.formation.startDate.year.toString()+" au "+Candidacy.formation.endDate.day.toString()+"-"+Candidacy.formation.endDate.month.toString()+"-"+Candidacy.formation.endDate.year.toString(), style: TextStyle(color: mainColor))
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
                Text(Candidacy.formation.description, style: TextStyle(color: mainColor))
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
            Text(fileName),
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
              child:RaisedButton.icon(padding: EdgeInsets.all(15),
                onPressed: isEnable ? ()=> uploadFile() : null,
                icon: Icon(Icons.badge),
                label: Text(Candidacy.user.getProfil()=='ROLE_PROF'? 'Former':'Se former',style: TextStyle(fontSize: 28),),
                color: mainColor,
                colorBrightness: Brightness.dark,
              )
          )
        ],
      ),
    );
  }


}
