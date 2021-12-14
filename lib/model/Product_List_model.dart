import 'dart:convert';

ProductListResponseModel productFromJson(String str) =>
    ProductListResponseModel.fromJson(json.decode(str));

class ProductListResponseModel {
  int status;
  List<Data> data;

  ProductListResponseModel({
    this.status,
    this.data,
  });

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductListResponseModel(
      status: json['status'],
      data: List<Data>.from(json['data'].map((e) => Data.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((e) => e.toJson()))
      };
}

class Data {
  int id;
  int productCategoryId;
  String name;
  String producer;
  String description;
  int cost;
  int rating;
  int viewCount;
  String created;
  String modified;
  String productImages;

  Data({
    this.id,
    this.productCategoryId,
    this.name,
    this.producer,
    this.description,
    this.cost,
    this.rating,
    this.viewCount,
    this.created,
    this.modified,
    this.productImages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        productCategoryId: json['product_category_id'],
        name: json['name'],
        producer: json['producer'],
        description: json['description'],
        cost: json['cost'],
        rating: json['rating'],
        viewCount: json['view_count'],
        created: json['created'],
        modified: json['modified'],
        productImages: json['product_images'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_category_id": productCategoryId,
        "name": name,
        "producer": producer,
        "description": description,
        "cost": cost,
        "rating": rating,
        "view_count": viewCount,
        "created": created,
        "modified": modified,
        "product_images": productImages,
      };
}
