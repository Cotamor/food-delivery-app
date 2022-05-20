import 'dart:convert';

import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences prefs;
  CartRepo({required this.prefs});
  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) async {
    // prefs.remove(AppConstants.cartList);
    // prefs.remove(AppConstants.cartHistoryList);
    // return;
    var time = DateTime.now().toString();
    cart = [];
    // convert objects to string because sharedpreferences only accept string.
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    prefs.setStringList(AppConstants.CART_LIST, cart);
    // print(prefs.getStringList(AppConstants.cartList));

    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (prefs.containsKey(AppConstants.CART_LIST)) {
      carts = prefs.getStringList(AppConstants.CART_LIST)!;
      // print('Inside getCartList : $carts');
    }
    // List<String> to json using jsonDecode() method, json to List<CartModel> using fromJson method!
    List<CartModel> cartList = [];

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (prefs.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = prefs.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    // List<String> to json using jsonDecode() method, json to List<CartModel> using fromJson method!
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (prefs.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = prefs.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (var i = 0; i < cart.length; i++) {
      print('history list: ${cart[i]}');
      cartHistory.add(cart[i]);
    }
    removeCart();
    prefs.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print('the length of history list: ${getCartHistoryList().length}');
    for (var j = 0; j < getCartHistoryList().length; j++) {
      print('the time for the order is ${getCartHistoryList()[j].time}');
    }
    // getCartHistoryList();
  }

  void removeCart() async {
    cart = [];
    await prefs.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory() async {
    removeCart();
    cartHistory = [];
    await prefs.remove(AppConstants.CART_HISTORY_LIST);
  }
}
