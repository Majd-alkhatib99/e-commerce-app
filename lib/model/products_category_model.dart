
class ProductsCategoryModel {
  List<ProductsCategoryDataModel>? data;

  ProductsCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ProductsCategoryDataModel.fromJson(v));
      });
    }
  }


}

class ProductsCategoryDataModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? quantity;
  int? active;
  int? catId;
  String? photo;
  String? createdAt;
  String? updatedAt;

  ProductsCategoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description']??'';
    price = json['price'];
    quantity = json['quantity'];
    active = json['active'];
    catId = json['cat_id'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

