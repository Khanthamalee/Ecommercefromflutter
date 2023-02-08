import 'package:ecommerce/data/repository/recommended_product_repo.dart';
import 'package:ecommerce/model/recommended_model.dart';
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
      print("got RecommendedProducts");
      //Build Model Nested Json
      _recommendedProductList = [];
      _recommendedProductList
          .addAll(RecommendedGoods.fromJson(response.body).product);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      print("error");
    }
  }
}
