import 'entite/formation.dart';
import 'package:http/http.dart' as http;
import 'entite/utilisateur.dart';
import 'entite/insertUser.dart';

//List des formations
Future<List<Formation>> fetchFormation() async {
  String url = "http://192.168.1.104/webservice/index.php?action=formlist";
  final response = await http.get(url);
  return listFromMap(response.body).formation;
}

//Info utilisateur
Future<Utilisateur> fetchUser(String login) async {
  String url = "http://192.168.1.104/webservice/index.php?action=list&map="+login;
  final response = await http.get(url);
  return userFromMap(response.body).utilisateur;
}

//Creation d'un compte utilisateur
Future<Data> newAccount(Utilisateur user, DateTime update, String mdp) async {
  String url = "http://192.168.1.104/webservice/index.php?action=add&login="+user.email+"&civilite="+user.civilite+"&matricule="+user.matricule+"&cni="+user.numeroCni+"&delivrance="+user.dateDelivrance.toString()+"&expiration="+user.dateExpiration.toString()+"&tel="+user.phoneNumber+"&nom="+user.firstName+"&prenom="+user.lastName+"&sexe="+user.sexe+"&dateNais="+user.dateOfBird.toString()+"&profil="+user.authorityName+"&etablissement="+user.nomEtablissement+"&email="+user.email+"&mdp="+mdp+"&update="+update.toString();
  final response = await http.get(url);
  return insertFromMap(response.body).data;
}

//Connexion utilisateur
Future<Data> fetchConnectionUser(String map, String search) async {
  String url = "http://192.168.1.104/webservice/index.php?action=connect&&map="+map+"&&search="+search;
  final response = await http.get(url);
  return insertFromMap(response.body).data;
}


//update utilisateur
Future<Data> updateUser(Utilisateur user, DateTime update, String mdp) async {
  String url = "http://192.168.1.104/webservice/index.php?action=edit&login="+user.email+"&civilite="+user.civilite+"&matricule="+user.matricule+"&cni="+user.numeroCni+"&delivrance="+user.dateDelivrance.toString()+"&expiration="+user.dateExpiration.toString()+"&tel="+user.phoneNumber+"&nom="+user.firstName+"&prenom="+user.lastName+"&sexe="+user.sexe+"&dateNais="+user.dateOfBird.toString()+"&profil="+user.authorityName+"&etablissement="+user.nomEtablissement+"&email="+user.email+"&mdp="+mdp+"&update="+update.toString();
  final response = await http.get(url);
  return insertFromMap(response.body).data;
}