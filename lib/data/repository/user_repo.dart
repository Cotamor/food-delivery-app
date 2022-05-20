import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/data/api/api_client.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({
    required this.apiClient,
  });

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}
