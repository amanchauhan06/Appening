import 'package:shared_preferences/shared_preferences.dart';

getFilterList() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> filters = prefs.getStringList("Filters List") ?? null;
  return filters;
}