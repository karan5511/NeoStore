import 'dart:convert';

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));

class CartItems {
  int status;
  List<Data> data;
  int count;
  int total;
  String message;
  String user_msg;

  CartItems(
      {this.status,
      this.data,
      this.count,
      this.total,
      this.message,
      this.user_msg});

  factory CartItems.fromJson(Map<String, dynamic> json) {
    return CartItems(
        status: json['status'],
        data:
            List<Data>.from(json['data'].map((x) => Data.fromJson(x))).toList(),
        message: json['message'],
        user_msg: json['user_msg'],
        count: json['count'],
        total: json['total']);
  }
}

class Data {
  int id;
  int product_id;
  int quantity;
  Product product;

  Data({
    this.id,
    this.product_id,
    this.quantity,
    this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      product_id: json['product_id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  int id;
  String name;
  int cost;
  String product_category;
  String product_images;
  int sub_total;

  Product(
      {this.id,
      this.name,
      this.cost,
      this.product_category,
      this.product_images,
      this.sub_total});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        cost: json['cost'],
        product_category: json['product_category'],
        product_images: json['product_images'],
        sub_total: json['sub_total']);
  }
}
