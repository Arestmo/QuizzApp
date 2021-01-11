import 'package:flutter/material.dart';
import 'package:quiz_app/models/questionModel.dart';
import 'package:quiz_app/server/requests.dart';
import 'package:quiz_app/widgets/widgets.dart';

class AddedQuestions extends StatefulWidget {
  final String userEmail;
  AddedQuestions({this.userEmail});
  @override
  _AddedQuestionsState createState() => _AddedQuestionsState();
}

class _AddedQuestionsState extends State<AddedQuestions> {
  List<QuestionModel> questions;
  @override
  void initState() {
    super.initState();
    getPendingQuestions(widget.userEmail).then((value){
      setState(() {
        questions = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context, "QuestionsStatus"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          questions == null
              ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return PendingQuestionTile(
                question: questions[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
