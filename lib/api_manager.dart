import 'entite/formation.dart';
import 'package:http/http.dart' as http;
import 'entite/utilisateur.dart';
import 'entite/insertUser.dart';

Future<List<Formation>> fetchFormation() async {
  String url = "http://192.168.1.104/webservice/index.php?action=formlist";
  final response = await http.get(url);
  return listFromMap(response.body).formation;
}

Future<Data> newAccount() async {
  String url = "http://192.168.1.104/webservice/index.php?action=add&&login=dylane&&civilite=M&&matricule=etd23&&cni=234530821&&delivrance=2020-2-23&&expiration=2030-10-1&&tel=675432098&&nom=Nemadjeu&&prenom=Brice&&sexe=HOMME&&dateNais=1997-10-21&&profil=Etudiant&&etablissement=ISJ&&email=bricenemadjeu@gmail.com&&mdp=dylane&&update=2021-1-13";
  final response = await http.get(url);
  return insertFromMap(response.body).data;
}
