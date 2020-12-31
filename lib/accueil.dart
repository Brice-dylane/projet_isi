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
        body: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  _headerTitle(),
                  _secondTitle(),
                  _search(),
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
              backgroundColor: mainColor,
            ),
          ],
        ),
      );
  }

  Widget _headerTitle(){
    return Container(
      margin: EdgeInsets.only(top: 60.0,left: MediaQuery.of(context).size.width/6,),
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
      margin: EdgeInsets.only(top: 30.0,left: MediaQuery.of(context).size.width/4),

      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.badge, color: mainColor,size: 50.0),
                new Text(' Nos formations', style: TextStyle(fontSize: MediaQuery.of(context).size.height / 30),)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _search(){
    return Container(
      margin: EdgeInsets.only(top: 30.0,left: MediaQuery.of(context).size.width/40),
      width: MediaQuery.of(context).size.width/3,
      color: Colors.black12,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.search, size: 30.0),
            onPressed: (){
              print('search');
            },
          ),

        ],
      ),
    );
  }

  Widget _itemsFormation(){
    return Container(
      child: FutureBuilder(
        future: fetchFormation(),
        builder: (context, snapshot){
          if(snapshot.hasData){

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
          Text('Lorem ipsum dolor sit amet, consecmagna aliqua. Ut enim ad minim veniam, quis, consecmagna aliqua. Ut enim ad minim veniam, quis, consecmagna aliqua. Ut enim ad minim veniam, quis ...')
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