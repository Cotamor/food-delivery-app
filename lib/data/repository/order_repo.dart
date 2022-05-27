import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/data/api/api_client.dart';
import 'package:food_deli/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderRepo {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }
}
