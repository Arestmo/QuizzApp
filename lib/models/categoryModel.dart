class CategoryModel {
  final int categoryId;
  final String categoryName;
  final String categoryUrl;

  CategoryModel({this.categoryName, this.categoryId, this.categoryUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['categoryName'],
      categoryId: json['categoryId'],
      categoryUrl: json['categoryUrl'],
    );
  }
}
