import 'package:flutter/material.dart';
import 'package:quiz_app/models/topusersModel.dart';
import 'package:quiz_app/server/requests.dart';
import 'package:quiz_app/widgets/widgets.dart';

class RankTop extends StatefulWidget {
  final int topItems;

  RankTop({this.topItems});

  @override
  _RankTopState createState() => _RankTopState();
}

class _RankTopState extends State<RankTop> {
  List<TopUsersModel> topUsers;

  @override
  void initState() {
    super.initState();
    getTopUsers().then((value) {
      setState(() {
        topUsers = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context, "TopPlayers"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: topUsers == null
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  return SingleUserTile(
                    topUser: topUsers[index],
                    index: index,
                  );
                }, childCount: topUsers.length))
              ],
            ),
    );
  }
}
