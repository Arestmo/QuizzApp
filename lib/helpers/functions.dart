import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String userLoggedInKey = 'USERLOGGEDINKEY';
  static String isUserAdmin = 'ISUSERADMIN';
  static String userToken = 'USERTOKEN';
  static String userEmail = 'USEREMAIL';
  static String numberOfQuestionPerGame = 'NUMBEROFQUESTIONPERGAME';


  static saveUserLoggedDetails({bool isLoggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLoggedInKey, isLoggedin);
  }

  static Future<bool> getUserLoggedInDetails () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }

  static setAdminIsLoggedIn({bool isAdmin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isUserAdmin, isAdmin);
  }

  static Future<bool> isAdminLogged () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isUserAdmin);
  }

  static setUserToken({String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userToken, token);
  }

  static Future<String> getUserToken () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userToken);
  }

  static setUserEmail({String email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userEmail, email);
  }

  static Future<String> getUserEmail () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmail);
  }

  static setQuestionPerGame({int quesionsPerGame}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(numberOfQuestionPerGame, quesionsPerGame);
  }

  static Future<int> getQuestionPerGame () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(numberOfQuestionPerGame);
  }


}
