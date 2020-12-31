import 'entite/formation.dart';
import 'package:http/http.dart' as http;

Future<List<Formation>> fetchFormation() async {
  String url = "http://192.168.1.105/webservice/index.php?action=formlist";
  final response = await http.get(url);
  return welcomeFromMap(response.body).formation;
}
