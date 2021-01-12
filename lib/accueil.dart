import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_isi/entite/formation.dart';
import 'api_manager.dart';
import 'constants.dart';
import 'connexion.dart';
import 'newAccount.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AcceuilPage extends StatefulWidget {
  @override
  _AcceuilPage createState() => _AcceuilPage();
}

class _AcceuilPage extends State<AcceuilPage> {



  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
                children: <Widget>[
                  _headerTitle(),
                  _secondTitle(),
                  _itemsFormation(),
                ],
              ),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: _connectionPage,
              label: Text('Se Connecter'),
              icon: Icon(Icons.lock),
              backgroundColor: Colors.teal,
            ),
          ],
        ),
      );
  }

  Widget _headerTitle(){
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(top: 60.0,left: 16.0),
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
      margin: EdgeInsets.only(top: 30.0,left: 15.0),
      alignment: Alignment.bottomCenter,
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
                      return Container(

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
                                  Icon(Icons.badge,size: 25.0, color: Colors.white),
                                  Text(' ${formation.formationName}'.toUpperCase(),style: TextStyle(fontSize: 12.0, color: Colors.white))
                                ],
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                                child: Text('Spécialité: ${formation.formationSpecialite}',style: TextStyle(color: Colors.white)),
                              ),
                              Text('${formation.description}',style: TextStyle(color: Colors.white)),
                              Container(
                                  alignment: Alignment.bottomRight,
                                  margin: EdgeInsets.only(left: 0.0),
                                  child: Text("Du "+formation.startDate.day.toString()+"-"+formation.startDate.month.toString()+"-"+formation.startDate.year.toString()+" au "+formation.endDate.day.toString()+"-"+formation.endDate.month.toString()+"-"+formation.endDate.year.toString(),style: TextStyle(fontSize: 10.0, color: Colors.white))
                              )
                            ],
                          ),
                        ),
                      );
                    }
                )
            );
          }
          return CircularProgressIndicator();
        },
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