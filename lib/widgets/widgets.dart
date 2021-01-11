import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/helpers/functions.dart';
import 'package:quiz_app/models/categoryModel.dart';
import 'package:quiz_app/models/questionModel.dart';
import 'package:quiz_app/models/topusersModel.dart';
import 'package:quiz_app/server/requests.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/addedquestions.dart';
import 'package:quiz_app/views/adminpanel.dart';
import 'package:quiz_app/views/ranktop.dart';
import 'package:quiz_app/views/settings.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/views/userstats.dart';
import 'package:recase/recase.dart';

AuthService authService = new AuthService();

Widget appBar(BuildContext context, String appBarTitle) {
  ReCase rc = new ReCase(appBarTitle);
  var words = rc.titleCase.split(" ");
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: words[0],
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
        TextSpan(
            text: words[1],
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
      ],
    ),
  );
}

Widget buttonGreen(BuildContext context, String buttonLabel) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
        color: Colors.green, borderRadius: BorderRadius.circular(50)),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    child:
        Text(buttonLabel, style: TextStyle(color: Colors.white, fontSize: 20)),
  );
}

class SingleAnswerTile extends StatefulWidget {
  final String answerText;
  final String isChosen;
  final bool isCorrect;

  SingleAnswerTile({this.answerText, this.isChosen, this.isCorrect});

  @override
  _SingleAnswerTileState createState() => _SingleAnswerTileState();
}

class _SingleAnswerTileState extends State<SingleAnswerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 30,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.isChosen == widget.answerText
              ? widget.isCorrect == true
                  ? Colors.green
                  : Colors.red
              : Colors.grey),
      alignment: Alignment.center,
      child: Text(
        widget.answerText,
        style: TextStyle(
            color: widget.isChosen == widget.answerText
                ? Colors.white
                : Colors.black),
      ),
    );
  }
}

class SingleQuestionTile extends StatefulWidget {
  final QuestionModel questionModel;

  SingleQuestionTile({this.questionModel});

  @override
  _SingleQuestionTileState createState() => _SingleQuestionTileState();
}

class _SingleQuestionTileState extends State<SingleQuestionTile> {
  String isChosen;
  bool isCorrect;

  @override
  void initState() {
    widget.questionModel.answers.shuffle();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 24,
                child: Center(
                  child: Text(
                    widget.questionModel.questionTitle,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      isChosen = widget.questionModel.answers[0];
                      if (widget.questionModel.answers[0] ==
                          widget.questionModel.correctAnswer) {
                        isCorrect = true;
                        widget.questionModel.answeredCorrect = true;
                      } else {
                        isCorrect = false;
                      }
                      widget.questionModel.answered = true;
                      setState(() {});
                    }
                  },
                  child: SingleAnswerTile(
                    answerText: widget.questionModel.answers[0],
                    isChosen: isChosen,
                    isCorrect: isCorrect,
                  )),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      isChosen = widget.questionModel.answers[1];
                      if (widget.questionModel.answers[1] ==
                          widget.questionModel.correctAnswer) {
                        isCorrect = true;
                        widget.questionModel.answeredCorrect = true;
                      } else {
                        isCorrect = false;
                      }
                      widget.questionModel.answered = true;
                      setState(() {});
                    }
                  },
                  child: SingleAnswerTile(
                    answerText: widget.questionModel.answers[1],
                    isChosen: isChosen,
                    isCorrect: isCorrect,
                  )),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      isChosen = widget.questionModel.answers[2];
                      if (widget.questionModel.answers[2] ==
                          widget.questionModel.correctAnswer) {
                        isCorrect = true;
                        widget.questionModel.answeredCorrect = true;
                      } else {
                        isCorrect = false;
                      }
                      widget.questionModel.answered = true;
                      setState(() {});
                    }
                  },
                  child: SingleAnswerTile(
                    answerText: widget.questionModel.answers[2],
                    isChosen: isChosen,
                    isCorrect: isCorrect,
                  )),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      isChosen = widget.questionModel.answers[3];
                      if (widget.questionModel.answers[3] ==
                          widget.questionModel.correctAnswer) {
                        isCorrect = true;
                        widget.questionModel.answeredCorrect = true;
                      } else {
                        isCorrect = false;
                      }
                      widget.questionModel.answered = true;
                      setState(() {});
                    }
                  },
                  child: SingleAnswerTile(
                    answerText: widget.questionModel.answers[3],
                    isChosen: isChosen,
                    isCorrect: isCorrect,
                  )),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool _isAdmin = false;
  String userEmail;

  @override
  void initState() {
    checkIsAdmin();
    getUserEmail();
    super.initState();
  }

  getUserEmail() async {
    HelperFunctions.getUserEmail().then((value) {
      setState(() {
        userEmail = value;
      });
    });
  }

  checkIsAdmin() async {
    HelperFunctions.isAdminLogged().then((value) {
      setState(() {
        _isAdmin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              decoration: BoxDecoration(color: Colors.green),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.star,
              color: Colors.green,
            ),
            title: Text('Top 10'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RankTop(topItems: 10)));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.stacked_bar_chart,
              color: Colors.green,
            ),
            title: Text('My Stats'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserStats(userEmail: userEmail)));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer_outlined,
              color: Colors.green,
            ),
            title: Text('Added Questions'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddedQuestions(userEmail: userEmail)));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.green,
            ),
            title: Text('Logout'),
            onTap: () {
              authService.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          ),
          (_isAdmin == true
              ? ListTile(
                  leading: Icon(
                    Icons.admin_panel_settings,
                    color: Colors.green,
                  ),
                  title: Text('Admin Panel'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminPanel()));
                  },
                )
              : Text("")),
        ],
      ),
    );
  }
}

class PendingQuestionTile extends StatefulWidget {
  final QuestionModel question;

  PendingQuestionTile({this.question});

  @override
  _PendingQuestionTileState createState() => _PendingQuestionTileState();
}

class _PendingQuestionTileState extends State<PendingQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: widget.question.approved == true ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text(widget.question.questionTitle, style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

class CategoryStatsTiles extends StatelessWidget {
  final List<CategoryModel> categories;
  final String userEmail;
  final int days;

  CategoryStatsTiles({this.categories, this.userEmail, this.days});

  @override
  Widget build(BuildContext context) {
    return categories != null
        ? CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                return QuizStatsTitle(
                  title: categories[index].categoryName,
                  imgUrl: categories[index].categoryUrl,
                  id: categories[index].categoryId,
                  userEmail: userEmail,
                  days: days,
                );
              }, childCount: categories.length))
            ],
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}

class QuizStatsTitle extends StatefulWidget {
  final String imgUrl;
  final String title;
  final int id;
  final String userEmail;
  final int days;

  QuizStatsTitle(
      {@required this.imgUrl,
      @required this.title,
      @required this.id,
      @required this.userEmail,
      @required this.days});

  @override
  _QuizStatsTitleState createState() => _QuizStatsTitleState();
}

class _QuizStatsTitleState extends State<QuizStatsTitle> {
  double _percent;

  @override
  void initState() {
    super.initState();
    getUserStats(widget.userEmail, widget.id.toString(), widget.days)
        .then((value) {
      setState(() {
        _percent = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      height: 130,
      alignment: Alignment.center,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.imgUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black26,
            ),
            child: Text(
              "${widget.title} : ${_percent.toString()}%",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleUserTile extends StatefulWidget {
  final TopUsersModel topUser;
  final int index;

  SingleUserTile({this.topUser, this.index});

  @override
  _SingleUserTileState createState() => _SingleUserTileState();
}

class _SingleUserTileState extends State<SingleUserTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      height: 90,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black26,
            ),
            child: Text(
              "${widget.index+1}:${widget.topUser.userEmail} - ${widget.topUser.userPercents}%",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,),
            ),
          ),
        ],
      ),
    );
  }
}
