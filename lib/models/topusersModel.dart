class TopUsersModel {
  final String userEmail;
  final String userPercents;

  TopUsersModel({this.userEmail, this.userPercents});

  factory TopUsersModel.fromJson(Map<String, dynamic> json) {
    return TopUsersModel(
      userEmail: json['user_email'],
      userPercents: json['percents'],
    );
  }
}
