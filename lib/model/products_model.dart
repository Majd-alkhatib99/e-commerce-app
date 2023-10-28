class ProductsModel {
  List<ProductsDataModel>? data;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data =[];
      json['data'].forEach((v) {
        data!.add( ProductsDataModel.fromJson(v));
      });
    }
  }

}

class ProductsDataModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? quantity;
  int? active;
  int? catId;
  String? photo;
  Category? category;



  ProductsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    active = json['active'];
    catId = json['cat_id'];
    photo = json['photo'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }


}

class Category {
  int? id;
  String? name;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}
