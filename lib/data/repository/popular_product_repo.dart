import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/data/api/api_client.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    // return await apiClient.getData(AppConstants.drinksURI);
    return await apiClient.getData(AppConstants.popularProductURI);
  }
}
