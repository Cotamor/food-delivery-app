import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/data/repository/popular_product_repo.dart';
import 'package:food_deli/models/products_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({
    required this.popularProductRepo,
  });
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _isLoaded = true;
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      print('increment: $_quantity');
      _quantity = checkQuantity(_quantity + 1);
    } else {
      print('decrement: $_quantity');
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        'Item count',
        'You can not reduce more !',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if (quantity > 10) {
      Get.snackbar(
        'Item count',
        'You can not add more !',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 10;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    // Initialize cart controller
    _cart = cart;

    // if exist
    // get from storage _inCartItmes = 3
  }

  void addItem(ProductModel product) {
    if (_quantity > 0) {
      _cart.addItem(product, _quantity);
      _cart.items.forEach((key, value) {
        print(
            'Name:${value.name}, Id: ${value.id}, Quantity: ${value.quantity}');
      });
    }
    Get.snackbar(
      'Item Count',
      'You should at least one item to the cart',
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,
    );
  }
}
