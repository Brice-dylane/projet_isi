import 'entite/formation.dart';
import 'package:http/http.dart' as http;
import 'entite/utilisateur.dart';
import 'entite/insertUser.dart';

Future<List<Formation>> fetchFormation() async {
  String url = "http://192.168.1.102/webservice/index.php?action=formlist";
  final response = await http.get(url);
  return welcomeFromMap(response.body).formation;
}

Future<Data> newAccount(Utilisateur user) async {
  String url = "http://192.168.1.102/webservice/add.php?nom="+user.nom+"&&prenom="+user.prenom+"&&sexe="+user.sexe+"&&dateNais="+user.dateNais.toString()+"&&profil="+user.profil+"&&etablissement="+user.etablissement+"&&email="+user.login+"&&mdp="+user.pwd+"&&update="+user.lastUpdate.toString();
  final response = await http.get(url);
  return insertFromMap(response.body).data;
}
