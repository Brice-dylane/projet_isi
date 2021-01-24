import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projet_isi/constants.dart';
import 'package:projet_isi/entite/formation.dart';
import 'package:projet_isi/entite/utilisateur.dart';
import 'package:projet_isi/ui_utilisateur/candidacy.dart';
import '../api_manager.dart';
import 'menu.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class MainPage extends StatefulWidget{
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage>{
  int _currentIndex = 0;
  final tabs = [

    Container(
        child: Column(
          children: <Widget>[
            Center(child: Row(
              children: <Widget>[
                Text('Formations ISJ', style: TextStyle(fontSize: 25.0, color: mainColor)),
              ],
            )),
            FutureBuilder(
              future: FlutterSession().get('token'),
                builder: (context, snapshot1){
                if(snapshot1.hasData){
                  String log = snapshot1.data;
                  return  FutureBuilder<Utilisateur>(
                      future: fetchUser(log),
                      builder: (context, AsyncSnapshot<Utilisateur> snapshot2){
                        if(snapshot2.hasData){
                          Utilisateur user = snapshot2.data;
                         // ----------------------------------------------------------------------------------------------
                          return FutureBuilder(
                            future: fetchFormation(),
                            builder: (context, snapshot){
                              if(snapshot.hasData){
                                return Expanded(
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      shrinkWrap: true,
                                      itemBuilder:(BuildContext context, index){
                                        Formation formation = snapshot.data[index];
                                        return Card(
                                          elevation: 10.0,
                                          margin: EdgeInsets.only(top: 20.0,left: 20.0, right: 20.0),
                                          color: mainColor,
                                          child: Container(
                                            margin: EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.badge, color: Colors.white),
                                                    Text(' ${formation.formationName}'.toUpperCase(),style: TextStyle(color: Colors.white))
                                                  ],
                                                ),

                                                Container(
                                                  margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                                                  child: Text('Spécialité: ${formation.formationSpecialite}',style: TextStyle(color: Colors.white)),
                                                ),
                                                Text('${formation.description}',style: TextStyle(color: Colors.white)),
                                                Container(
                                                    alignment: Alignment.bottomLeft,
                                                    margin: EdgeInsets.only(left: 0.0,bottom: 10.0),
                                                    child: Text("Du "+formation.startDate.day.toString()+"-"+formation.startDate.month.toString()+"-"+formation.startDate.year.toString()+" au "+formation.endDate.day.toString()+"-"+formation.endDate.month.toString()+"-"+formation.endDate.year.toString(),style: TextStyle(fontSize: 15.0, color: Colors.white))
                                                ),
                                                Container(
                                                  alignment: Alignment.bottomRight,
                                                  child: RaisedButton(
                                                    elevation: 5.0,
                                                    color: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30.0),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Candidacy(formation,user)
                                                      ));
                                                    },
                                                    child: Text(
                                                      user.getProfil()=='ROLE_PROF'? 'Former >':'Se former >',
                                                      style: TextStyle(
                                                        color: mainColor,
                                                        letterSpacing: 1.5,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                );
                              }
                              return CircularProgressIndicator();
                            },
                          );
                          //-------------------------------------------------------------------------------------------------------------------
                        }
                        return CircularProgressIndicator();
                      }
                  );
                }
                return CircularProgressIndicator();
                },

            ),

          ],
        ),
      ),
    Center(child: Text('Mes Formations')),

    Column(
      children: <Widget>[
        Flexible(
          flex: 2,
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.teal,
              child: Column(
                children: <Widget>[
                  Icon(Icons.badge, color: Colors.white,),
                  Text('2 Formation(s)', style: TextStyle(color: Colors.white),),
                  Text('Encours', style: TextStyle(color: Colors.white70),),
                ],
              ),
            )
        ),
        Flexible(flex: 2 ,child: Container(
          alignment: AlignmentDirectional.topEnd,
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(left: 5.0),
          color: Colors.teal,
          child: Column(
            children: <Widget>[
              Icon(Icons.emoji_people, color: Colors.white,),
              Text('1 Formation(s)', style: TextStyle(color: Colors.white),),
              Text('Terminée', style: TextStyle(color: Colors.white70),),
            ],
          ),
        ))
      ],
    ),

  ];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Apply to ISJ - Formations'),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
            title: Text('Formations ISJ'),
            backgroundColor: mainColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.badge),
              title: Text('Mes formations'),
              backgroundColor: mainColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Mon Rapport'),
              backgroundColor: mainColor
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: Drawer(
        child: MenuUser(),
      ),
    );
  }



}