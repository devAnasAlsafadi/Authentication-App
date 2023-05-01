class Category {
  late int id;
  late String title;
  late String description;
  late String image;
  late String visible;
  late String productsCount;


  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    visible = json['visible'];
    productsCount = json['products_count'];
  }

}