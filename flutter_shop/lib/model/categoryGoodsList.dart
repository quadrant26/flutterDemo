class CategoryGoodsListModel {
  int result;
  List<CategoryListData> data;
  int total;

  CategoryGoodsListModel({this.result, this.data, this.total});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = new List<CategoryListData>();
      json['data'].forEach((v) {
        data.add(new CategoryListData.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class CategoryListData {
  String catId;
  String goodsId;
  String goodsName;
  String marketPrice;
  String shopPrice;
  String goodsThumb;
  String goodsImg;
  String originalImg;
  String goodsNumber;
  String goodsDesc;

  CategoryListData(
      {this.catId,
      this.goodsId,
      this.goodsName,
      this.marketPrice,
      this.shopPrice,
      this.goodsThumb,
      this.goodsImg,
      this.originalImg,
      this.goodsNumber,
      this.goodsDesc});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    marketPrice = json['market_price'];
    shopPrice = json['shop_price'];
    goodsThumb = json['goods_thumb'];
    goodsImg = json['goods_img'];
    originalImg = json['original_img'];
    goodsNumber = json['goods_number'];
    goodsDesc = json['goods_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['market_price'] = this.marketPrice;
    data['shop_price'] = this.shopPrice;
    data['goods_thumb'] = this.goodsThumb;
    data['goods_img'] = this.goodsImg;
    data['original_img'] = this.originalImg;
    data['goods_number'] = this.goodsNumber;
    data['goods_desc'] = this.goodsDesc;
    return data;
  }
}