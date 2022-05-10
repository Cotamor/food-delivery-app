import 'dart:convert';

import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences shearedPreferences;

  CartRepo({required this.shearedPreferences});

  List<String> cart = [];
  void addToCartList(List<CartModel> cartList) {
    cart = [];
    // convert objects to string because sharedpreferences only accept string.
    cartList.forEach((element) {
      cart.add(jsonEncode(element));
    });
    shearedPreferences.setStringList(AppConstants.cartList, cart);
    print(shearedPreferences.getStringList(AppConstants.cartList));

    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (shearedPreferences.containsKey(AppConstants.cartList)) {
      carts = shearedPreferences.getStringList(AppConstants.cartList)!;
      print('Inside getCartList : $carts');
    }
    // List<String> to json using jsonDecode() method, json to List<CartModel> using fromJson method!
    List<CartModel> cartList = [];

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }
}
