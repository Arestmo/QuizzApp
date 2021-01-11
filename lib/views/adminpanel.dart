import 'package:flutter/material.dart';
import 'package:quiz_app/models/questionModel.dart';
import 'package:quiz_app/server/requests.dart';
import 'package:quiz_app/widgets/widgets.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {

  List<QuestionModel> pendingQuestions;

  void updateState() {
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getQuestionsToApprove().then((value) {
      setState(() {
       pendingQuestions = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context, "AdminPanel"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: pendingQuestions == null
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
                    return QuestionApproveTile(
                      pendingQuestion: pendingQuestions[index],
                    );
                  }, childCount: pendingQuestions.length))
        ],
      ),
    );
  }
}
