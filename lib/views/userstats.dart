import 'package:flutter/material.dart';
import 'package:quiz_app/models/categoryModel.dart';
import 'package:quiz_app/server/requests.dart';
import 'package:quiz_app/widgets/widgets.dart';

class UserStats extends StatefulWidget {
  final String userEmail;

  UserStats({this.userEmail});

  @override
  _UserStatsState createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  List<CategoryModel> allCategories;
  int days = 7;

  @override
  void initState() {
    super.initState();
    getAllCategories().then((value) {
      setState(() {
        allCategories = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context, "MyStats"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: CategoryStatsTiles(
        categories: allCategories,
        userEmail: widget.userEmail,
        days: days,
      ),
    );
  }
}
