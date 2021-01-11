import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz_app/helpers/functions.dart';
import 'package:quiz_app/models/questionModel.dart';
import 'package:quiz_app/server/requests.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlayQuiz extends StatefulWidget {
  final int categoryId;

  PlayQuiz({this.categoryId});

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  List<QuestionModel> questions;
  String email;
  int _numberOfQuestionPerGame;

  @override
  void initState() {
    HelperFunctions.getUserEmail().then((value) {
      setState(() {
        email = value;
      });
    });

    super.initState();
    HelperFunctions.getQuestionPerGame().then((value) {
      setState(() {
        _numberOfQuestionPerGame = value;
      });
      getQuestionByCategoryId(widget.categoryId, _numberOfQuestionPerGame)
          .then((value) {
        setState(() {
          questions = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context, "QuizzApp"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: questions == null
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
                  return SingleQuestionTile(
                    questionModel: questions[index],
                  );
                }, childCount: questions.length))
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
        onPressed: () {
          bool _isAllAnswered = true;
          int _total = questions.length;
          int _correct = 0;

          for (var question in questions) {
            if (!question.answered) {
              _isAllAnswered = false;
              break;
            }
            if (question.answeredCorrect) {
              _correct++;
            }
          }

          _isAllAnswered == false
              ? Fluttertoast.showToast(
                  msg: "You did not answer to all questions",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue[400],
                  textColor: Colors.white,
                  fontSize: 24,
                )
              : showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 10),
                                      blurRadius: 10),
                                ]),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Thanks for completed quiz",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Answered $_correct/$_total",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton(
                                      onPressed: () {
                                        pushCompletedQuiz(
                                            correctAnswers: _correct,
                                            userEmail: email,
                                            nofQuestions: _total,
                                            categoryId:
                                                widget.categoryId.toString());
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()));
                                      },
                                      child: Text(
                                        "Close",
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}
