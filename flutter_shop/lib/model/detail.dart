class DetailModel {
  int result;
  DetailGoodsData data;

  DetailModel({this.result, this.data});

  DetailModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ? new DetailGoodsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DetailGoodsData {
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
  String goodsSn;

  DetailGoodsData(
      {this.catId,
      this.goodsId,
      this.goodsName,
      this.marketPrice,
      this.shopPrice,
      this.goodsThumb,
      this.goodsImg,
      this.originalImg,
      this.goodsNumber,
      this.goodsDesc,
      this.goodsSn});

  DetailGoodsData.fromJson(Map<String, dynamic> json) {
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
    goodsSn = json['goods_sn'];
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
    data['goods_sn'] = this.goodsSn;
    return data;
  }
}