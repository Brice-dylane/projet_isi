import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projet_isi/api_manager.dart';
import 'package:projet_isi/connexion.dart';
import 'package:projet_isi/entite/utilisateur.dart';
import 'package:projet_isi/ui_utilisateur/mainPage.dart';
import 'package:projet_isi/ui_utilisateur/parametreUser.dart';

import '../constants.dart';

class MenuUser extends StatelessWidget{

  String nom = '';
  String prenom = '';
  String login = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: mainColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    height: 150.0,
                    margin: EdgeInsets.only(top: 30.0,bottom: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage('assets/logo.png'), fit: BoxFit.fill),

                    ),
                  ),
                  FutureBuilder(
                    future: FlutterSession().get('token'),
                      builder: (context,snapshot){
                      if(snapshot.hasData){
                        login = snapshot.data;
                        return FutureBuilder<Utilisateur>(
                          future: fetchUser(login),
                          builder: (context, AsyncSnapshot<Utilisateur> snapshot1){
                            if(snapshot1.hasData){
                              Utilisateur user = snapshot1.data;
                              prenom = user.getLastName();
                              nom = user.getFirstName();
                              return Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 60.0),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            prenom,
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                color: Colors.white
                                            ),
                                          ),
                                          Text(
                                            ' '+nom.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                color: Colors.white
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      login,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return Text('');
                          },
                        );
                      }
                    return Text('');
                  })
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.badge),
            title: Text(
              'Formations',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => MainPage()
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text(
              'Sessions',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Parametre()
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Déconnexion',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: (){
              FlutterSession().set('token', '');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

}