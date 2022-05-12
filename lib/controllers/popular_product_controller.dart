import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/data/repository/popular_product_repo.dart';
import 'package:food_deli/models/cart_model.dart';
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
      // print('increment _quantity: $_quantity');
      _quantity = checkQuantity(_quantity + 1);
    } else {
      // print('decrement _quantity: $_quantity');
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    // print(
    //     'quantity:$quantity, _quantity: $_quantity, _inCartItems: $_inCartItems');
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        'Item count',
        'You can not reduce more !',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if (_inCartItems + quantity > 10) {
      Get.snackbar(
        'Item count',
        'You can not add more !',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        return _quantity;
      }
      return 10;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    // Initialize cart controller
    _cart = cart;
    // if exist
    var exist = false;
    exist = _cart.existInCart(product);
    // get from storage _inCartItmes = 3
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print('quantity in the cart is $_inCartItems');
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    // for test purpose, print out what is inside the cart?
    // _cart.items.forEach((key, value) {
    // print('Name:${value.name}, Id: ${value.id}, Quantity: ${value.quantity}');
    // });
    //

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
