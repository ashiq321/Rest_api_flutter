class DatumProduct {
  DatumProduct({
    this.id,
    this.rating,
    this.totalrating,
    this.title,
    this.featureImg,
    this.salePrice,
    this.discount,
    this.discountAmount,
    this.finalPrice,
  });

  int id;
  int rating;
  int totalrating;
  String title;
  String featureImg;
  String salePrice;
  String discount;
  String discountAmount;
  String finalPrice;

  factory DatumProduct.fromJson(Map<String, dynamic> json) => DatumProduct(
        id: json["id"] == null ? null : json["id"],
        rating: json["rating"] == null ? null : json["rating"],
        totalrating: json["totalrating"] == null ? null : json["totalrating"],
        title: json["title"] == null ? null : json["title"],
        featureImg: json["feature_img"] == null ? null : json["feature_img"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        discount: json["discount"] == null ? null : json["discount"],
        discountAmount:
            json["discount_amount"] == null ? null : json["discount_amount"],
        finalPrice: json["final_price"] == null ? null : json["final_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "rating": rating == null ? null : rating,
        "totalrating": totalrating == null ? null : totalrating,
        "title": title == null ? null : title,
        "feature_img": featureImg == null ? null : featureImg,
        "sale_price": salePrice == null ? null : salePrice,
        "discount": discount == null ? null : discount,
        "discount_amount": discountAmount == null ? null : discountAmount,
        "final_price": finalPrice == null ? null : finalPrice,
      };
}
