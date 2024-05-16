import 'package:shared_preferences/shared_preferences.dart';

class DataCollectionController {
  final SharedPreferences sharedPreferences;

  DataCollectionController(this.sharedPreferences);

  void saveData(String name,
      String age, String gender) {
    sharedPreferences.setString("userName", name);
    sharedPreferences.setString("userAge", age);
    sharedPreferences.setString("userGender", gender);
    sharedPreferences.setBool("hasRegistered", true);
  }
}
