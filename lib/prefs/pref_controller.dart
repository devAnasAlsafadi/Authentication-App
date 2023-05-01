import 'package:ellancer_api/models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController{
  SharedPrefController._internal();
  static final SharedPrefController _instance = SharedPrefController._internal();
  late SharedPreferences preferences;
  factory SharedPrefController(){
    return _instance;
  }

  Future<void> initShared()async{
    preferences = await SharedPreferences.getInstance();
  }


  Future<void> save({required Student student}) async {
    await preferences.setBool(PrefsKey.loggedIn.toString(), true);
    await preferences.setString(PrefsKey.email.toString(), student.email);
    await preferences.setString(PrefsKey.fullName.toString(), student.fullName);
    await preferences.setString(PrefsKey.gender.toString(), student.gender);
    await preferences.setString(PrefsKey.token.toString(), "Bearer "+student.token);
  }

  bool get loggedIn => preferences.getBool(PrefsKey.loggedIn.toString())??false;

  String get token => preferences.getString(PrefsKey.token.toString())??'';
  Future<bool> clear() async {
    return await preferences.clear();
 }
}

enum PrefsKey{
  email, fullName , token , gender, loggedIn
}