import 'dart:convert';

import 'package:ecommerce/data/repository/recommended_product_repo.dart';
import 'package:ecommerce/model/product_models.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();

    if (response.statusCode == 200) {
      /* ในกรณีที่ response.body เป็น map อยู่แล้วใช้แบบนี้ได้
      _recommendedProductList = [];
      _recommendedProductList
          .addAll(Goods.fromJson(response.body).product);*/
      _recommendedProductList =
          Goods.fromJson(jsonDecode(response.body)).product;
      //print(_popularProductList);
      _isLoaded = true;
      
      update();
      print("4. _recommendedProductList : ${_recommendedProductList} ===");
    } else {
      print("ไม่สามารถดึงข้อมูลจาก recommended ได้");
    }
  }
}
