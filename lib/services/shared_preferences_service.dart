import 'package:shared_preferences/shared_preferences.dart';
class SharedPref {

  static savefavoriteids(String? id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // print("sava ${id}");
  return sharedPreferences.setString("id", id!);
}

static Future<String?> loadfavoriteids() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("id");
}

static deletefavoriteids(String? id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.remove("$id");
}



}


