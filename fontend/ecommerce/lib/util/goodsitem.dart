class GoodsItems {
  final String directoryimage;

  GoodsItems(this.directoryimage);
}

// ignore: non_constant_identifier_names
List<GoodsItems> GoodsItemsList = [
  GoodsItems("assets/image_ui/flo.jpg"),
  GoodsItems("assets/image_ui/banana.jpg"),
  GoodsItems("assets/image_ui/soup.jpg"),
  GoodsItems("assets/image_ui/sunflower.png"),
  GoodsItems("assets/image_ui/watercress.png")
];

class Goodsnames {
  final String title;
  Goodsnames(this.title);
}

List<Goodsnames> GoodsnamesList = [
  Goodsnames("ดอกโป๊ยเซียน"),
  Goodsnames("กล้วยน้ำหว้า"),
  Goodsnames("สบู่"),
  Goodsnames("ดอกทานตะวัน"),
  Goodsnames("ดอกแพงพวย")
];
