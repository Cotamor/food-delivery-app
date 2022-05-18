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
    Response response = await apiClient.postData(AppConstants.registrationURI, singUpBody.toJson());
    return response;
  }

  Future<String> getUserToken() async {
    return prefs.getString(AppConstants.token) ?? 'None';
  }

  Future<Response> login(String email, String password) async {
    Response response = await apiClient.postData(AppConstants.loginURI, {'email': email, 'password': password});
    return response;
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await prefs.setString(AppConstants.token, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await prefs.setString(AppConstants.phone, number);
      await prefs.setString(AppConstants.password, password);
    } catch (e) {
      throw (e);
    }
  }
}
