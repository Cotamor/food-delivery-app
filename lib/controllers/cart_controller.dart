import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/data/repository/cart_repo.dart';
import 'package:food_deli/models/cart_model.dart';
import 'package:food_deli/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({
    required this.cartRepo,
  });

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  Map<int, CartModel> _history = {};
  Map<int, CartModel> get history => _history;
  // Only for storage and sharedPreferences
  List<CartModel> storageItems = [];
  List<CartModel> historyItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (value) {
          totalQuantity = value.quantity! + quantity;
          return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        },
      );
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          product.id!,
          () {
            return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product,
            );
          },
        );
      } else {
        Get.snackbar(
          'Item Count',
          'You should at least one item to the cart',
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  void addToHistoryAndClearCart() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map(
      (e) {
        return e.value;
      },
    ).toList();
  }

  List<CartModel> get getHistory {
    return _history.entries.map(
      (e) {
        return e.value;
      },
    ).toList();
  }

  int get getTotalAmount {
    var total = 0;
    _items.forEach((key, value) {
      final price = value.price;
      final quantity = value.quantity;
      total += price! * quantity!;
    });
    print('Total Price: $total');
    return total;
  }

  List<CartModel> getCartList() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print('Length of cart items: ${storageItems.length}');
    for (var i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  List<CartModel> getCartHistoryList() {
    // setHistory = cartRepo.getCartHistoryList();
    print('Length of history items: ${historyItems.length}');

    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  // set setHistory(List<CartModel> items) {
  //   historyItems = items;
  //   print('Length of history items: ${historyItems.length}');
  //   for (var i = 0; i < historyItems.length; i++) {
  //     _history.putIfAbsent(historyItems[i].product!.id!, () => historyItems[i]);
  //   }
  // }
}
