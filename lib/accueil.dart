import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_isi/entite/formation.dart';
import 'api_manager.dart';
import 'constants.dart';
import 'connexion.dart';
import 'newAccount.dart';

class AcceuilPage extends StatefulWidget {
  @override
  _AcceuilPage createState() => _AcceuilPage();
}

class _AcceuilPage extends State<AcceuilPage> {

  final _listFormation = [

  ];


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  _headerTitle(),
                  _secondTitle(),
                  _itemsFormation(),
                ],
              ),
            ),
          ),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: _connectionPage,
              label: Text('Se Connecter'),
              icon: Icon(Icons.supervisor_account_rounded),
              backgroundColor: Colors.teal,
            ),
          ],
        ),
      );
  }

  Widget _headerTitle(){
    return Container(
      margin: EdgeInsets.only(top: 60.0,left: MediaQuery.of(context).size.height/10),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            height: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 4,
            child: new Image.asset("assets/logo.png", fit: BoxFit.cover),
          ),
          Text('Apply To ISJ', style: TextStyle(fontSize: MediaQuery.of(context).size.height / 20, color: mainColor)),
        ],
      ),
    );
  }

  Widget _secondTitle(){
    return Container(
      margin: EdgeInsets.only(top: 30.0,left: MediaQuery.of(context).size.height / 6),

      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.badge, color: mainColor,size: 50.0),
                new Text(' Nos formations ', style: TextStyle(fontSize: MediaQuery.of(context).size.height / 30),),
                IconButton(
                  iconSize: 40.0,
                    icon: Icon(Icons.refresh),
                    onPressed: (){
                      setState(() {
                        fetchFormation();
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget _itemsFormation(){
    return Container(
      child: FutureBuilder(
        future: fetchFormation(),
        builder: (context, snapshot){
          if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder:(BuildContext context, index){
                    Formation formation = snapshot.data[index];
                    return Container(
                      margin: EdgeInsets.only(top: 20.0,left: 20.0, right: 20.0),
                      padding: EdgeInsets.all(20.0),
                      color: mainColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.badge,size: 20.0, color: Colors.white),
                              Text(' ${formation.titre}'.toUpperCase(),style: TextStyle(fontSize: 20.0, color: Colors.white))
                            ],
                          ),

                          Container(margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                          Text('${formation.description}',style: TextStyle(fontSize: 15.0, color: Colors.white)),
                          Container(
                              margin: EdgeInsets.only(top: 5.0,left: 0.0),
                            child:
                              Text('Activer',style: TextStyle(fontSize: 10.0, color: Colors.white))
                          )
                        ],
                      ),
                    );
                  }
              );
          }
            return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _formations(){
    return Container(
      margin: EdgeInsets.only(top: 40.0,left: 20.0, right: 20.0),
      padding: EdgeInsets.all(20.0),
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Text('Formation 1',style: TextStyle(fontSize: MediaQuery.of(context).size.height / 60)),
          Text('')
        ],
      ),
    );
  }

  void _connectionPage(){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => LoginPage()
    ));
  }

  void _createAccountPage(){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => CreateAccountPage()
    ));
  }

}