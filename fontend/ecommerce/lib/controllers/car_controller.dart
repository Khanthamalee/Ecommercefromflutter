import 'package:ecommerce/data/repository/cart_repo.dart';
import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/model/product_models.dart';
import 'package:ecommerce/util/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  void addItems(ProductModel product, int quantity) {
    var totalQuantity = 0;
    int _quantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        if (value.quantity! > 0 && value.quantity! <= 19) {
          totalQuantity = value.quantity! + quantity;
        } else if (value.quantity! > 19) {
          if (quantity <= 0) {
            totalQuantity = value.quantity! + quantity;
          } else {
            value.quantity = 20;
            totalQuantity = value.quantity!;
            Get.snackbar(
              "สินค้าไม่สามารถ",
              "เพิ่มจำนวนมากกว่า 20 ชิ้นค่ะ",
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
              duration: Duration(seconds: 1),
            );
          }
        }
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: totalQuantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else if (quantity > 0) {
      _items.putIfAbsent(product.id!, () {
        print("Adding item to the cart ${product.id}, quantity : $quantity");
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
      });
    } else {
      Get.snackbar(
        "ต้องเลือกสิ้นค้ามากกว่า 1 ชิ้น",
        "จึงสามารถสั่งซื้อสินค้าได้ค่ะ",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );
    }

    cartRepo.addToCartList(getItems);
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
    return _items.entries.map((e) {
      //print("e.value : ${e.value}");
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
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

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }
}
