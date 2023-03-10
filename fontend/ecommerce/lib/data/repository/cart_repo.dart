import 'dart:convert';

import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    //make sure cart = []
    cart = [];

    cartList.forEach((element) => cart.add(jsonEncode(element)));

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
    //print(
    //"sharedPreferences.getStringList('Cart-list') : ${sharedPreferences.getStringList("Cart-list")}");
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      //print("inside getCartList ${carts}");
    }
    List<CartModel> cartList = [];

    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    //print(carts.runtimeType);
    //print(cartList);
    return cartList;
  }

  void addToHistoryList() {
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
      print(cartHistory);
    }
    removedCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removedCart() {
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
