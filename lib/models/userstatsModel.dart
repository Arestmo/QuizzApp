class UserStatsModel {
  final int categoryId;
  final String categoryName;
  final String categoryUrl;

  UserStatsModel({this.categoryName, this.categoryId, this.categoryUrl});

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      categoryName: json['categoryName'],
      categoryId: json['categoryId'],
      categoryUrl: json['categoryUrl'],
    );
  }
}
