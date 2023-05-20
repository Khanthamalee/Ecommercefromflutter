import 'dart:convert';
import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    //return;
    //make sure cart = []
    var time = DateTime.now().toString();
    cart = [];

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
    //print(
    //"sharedPreferences.getStringList('Cart-list') : ${sharedPreferences.getStringList("Cart-list")}");
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList ${carts}");
    }
    List<CartModel> cartList = [];

    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    //print(carts.runtimeType);
    print(cartList);
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      //cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    //print("cartListHistory : $cartListHistory");

    return cartListHistory;
  }

  void addToHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
      print("cartHistory : $cartHistory");
    }

    removedCart();
    cart = [];
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);

    print("the lenght of history list is : ${getCartHistoryList().length}");
    for (int i = 0; i < getCartHistoryList().length; i++) {
      print("time of getCartHistoryList() : ${getCartHistoryList()[i].time}");
    }
  }

  void removedCart() {
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory() {
    removedCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
