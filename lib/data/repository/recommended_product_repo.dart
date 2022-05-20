import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/data/api/api_client.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCE_URI);
  }
}
