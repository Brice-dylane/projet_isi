import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projet_isi/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:projet_isi/ui_utilisateur/mainPage.dart';
import 'api_manager.dart';
import 'entite/insertUser.dart';
import 'entite/utilisateur.dart';
import 'newAccount.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String login='', password='';
  final _formKey = GlobalKey<FormState>();
  ProgressDialog progressDialog;

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 2.0),
          child: new Container(

            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            height: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 4,
            child: new Image.asset("assets/logo.png", fit: BoxFit.cover,),
          ),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Apply to ISJ",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 20,
                            color: mainColor
                        ),
                      ),
                    ],
                  ),
                  _buildLoginRow(),
                  _buildPasswordRow(),
                  _buildForgetPasswordButton(),
                  _buildLoginButton(),
                  _buildOrRow(),
                  _buildCreateBtnRow(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            login = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_circle,
              color: mainColor,
            ),
            labelText: 'Email'),
        validator: (val) => !EmailValidator.Validate(login,true)? 'Adresse mail non valide':null,
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            password = convertMdp(value);
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Mot de passe',
        ),
        validator: (val) => val.isEmpty ? 'Entrer le mot de passe':null,
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {

          },
          child: Text("Mot de passe oublié"),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    progressDialog = ProgressDialog(context, type:ProgressDialogType.Normal);
    progressDialog.style(
        message: 'Connexion en cours...',
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
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () async {
              if(_formKey.currentState.validate()){
                //password  = convertMdp(password);
                progressDialog.show();
                Data dataCreate = await fetchConnectionUser(login,password);

                if(dataCreate.status==1) {
                  //Utilisateur user = await fetchUser(login);

                  await FlutterSession().set('token', login);
                  connexionUser();
                }
                else{
                  progressDialog.hide();
                  dialog("Echec!", "Login ou mot de passe incorrecte",dataCreate.status);
                }

              }
            },
            child: Text(
              "Connexion",
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

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            '- OU -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCreateBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 8),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: newAccountPage,
            child: Text(
              "Créer un compte",
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

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xfff2f3f7),
        body: Container(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(70),
                        bottomRight: const Radius.circular(70),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(margin: EdgeInsets.only(top: 50.0)),
                    _buildContainer(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void newAccountPage(){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => CreateAccountPage()
    ));
  }

  void connexionUser(){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MainPage(),
      ),
          (route) => false,
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