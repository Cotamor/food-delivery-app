import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/data/api/api_client.dart';
import 'package:food_deli/models/sign_up_body_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences prefs;

  AuthRepo({
    required this.apiClient,
    required this.prefs,
  });

  Future<Response> registration(SignUpBody singUpBody) async {
    Response response = await apiClient.postData(AppConstants.REGISTRATION_URI, singUpBody.toJson());
    return response;
  }

  bool userLoggedin() {
    return prefs.containsKey(AppConstants.TOKEN);
  }

  Future<String> getUserToken() async {
    return prefs.getString(AppConstants.TOKEN) ?? 'None';
  }

  Future<Response> login(String email, String password) async {
    Response response = await apiClient.postData(AppConstants.LOGIN_URI, {'email': email, 'password': password});
    return response;
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await prefs.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await prefs.setString(AppConstants.EMAIL, number);
      await prefs.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw (e);
    }
  }

  bool clearSharedData() {
    prefs.remove(AppConstants.TOKEN);
    prefs.remove(AppConstants.EMAIL);
    prefs.remove(AppConstants.PASSWORD);
    apiClient.token = '';
    apiClient.updateHeader('');

    return true;
  }
}
