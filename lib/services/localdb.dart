import 'package:shared_preferences/shared_preferences.dart';

class localDB {
  static final uidKey = "kljhdjkvhdjfhvjdf";
  static final mKey = "sdfkjdsjfdjsfhdjksf";
  static final nKey = "sdkfbdsjfbdsjf";
  static final rKey = "aasfasfasfasffghg";
  static final urlKey = "asfjlasjkfbuierg";
  static final lKey = "sdjkfbsdkjfbjdsbfsdcjdsf";
  static final Audkey = "gswdgxertea";
  static final Jokkey = "65g1d24wtafder4ev45";
  static final F50key = "ffterybewryvwresw";
  static final ExpKey = "65g14eryjeryubs45wwwwascafder4ev45";

  static Future<bool> saveUserID(String uid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(uidKey, uid);
  }

  static Future<String?> getUserID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(uidKey);
  }

  static Future<String?> getMoney() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(mKey);
  }

  static Future<bool> saveMoney(int money) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(mKey, money.toString());
  }

  static Future<String?> getName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(nKey);
  }

  static Future<bool> saveName(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(nKey, name);
  }

  static Future<String?> getRank() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(rKey);
  }

  static Future<bool> saveRank(String rank) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(rKey, rank);
  }

  static Future<String?> getLevel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(lKey);
  }

  static Future<bool> saveLevel(String level) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(lKey, level);
  }

  static Future<String?> getUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(urlKey);
  }

  static Future<bool> saveUrl(String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(urlKey, url);
  }

  static Future<bool> saveAud(bool isAvail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(Audkey, isAvail);
  }

  static Future<bool?> getAud() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(Audkey);
  }

  static Future<bool> saveJoker(bool isAvail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("SHARED PREFRWENE");
    print(isAvail);
    return await preferences.setBool(Jokkey, isAvail);
  }

  static Future<bool?> getJoker() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(Jokkey);
  }

  static Future<bool> save50(bool isAvail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(F50key, isAvail);
  }

  static Future<bool?> get50() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(F50key);
  }

  static Future<bool> saveExp(bool isAvail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(ExpKey, isAvail);
  }

  static Future<bool?> getExp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(ExpKey);
  }
}
