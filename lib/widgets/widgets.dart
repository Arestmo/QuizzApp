import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/helpers/functions.dart';
import 'package:quiz_app/models/questionModel.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/signin.dart';
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
    setState(() {

    });
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

  @override
  void initState() {
    checkIsAdmin();
    super.initState();
  }

  checkIsAdmin() async {
    HelperFunctions.isAdminLogged().then((value) {
      setState(() {
        _isAdmin = value;
      });
    });
  }

  //eyJhbGciOiJSUzI1NiIsImtpZCI6ImUwOGI0NzM0YjYxNmE0MWFhZmE5MmNlZTVjYzg3Yjc2MmRmNjRmYTIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcXVpenphcHAtOWExNDUiLCJhdWQiOiJxdWl6emFwcC05YTE0NSIsImF1dGhfdGltZSI6MTYxMDMwMTI4MSwidXNlcl9pZCI6IlRkZzVHTlp1eUFiS1lySGk1MVJaMXAxcm9DSTMiLCJzdWIiOiJUZGc1R05adXlBYktZckhpNTFSWjFwMXJvQ0kzIiwiaWF0IjoxNjEwMzAxMjgxLCJleHAiOjE2MTAzMDQ4ODEsImVtYWlsIjoiYWRtaW5AZW1haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImFkbWluQGVtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.MACXFASCJXCQfucoh-Hik38-nCZ94ik8ssjONTTZ87LTna6g4cMc25MYdi_9Pq-MuvOvepDNcyg2o00u05_eGb8fJM6vf7nZNYJegv5jzi61G2RsHHceauTREQDRRdkeCniQSvDnEWdDXBuC_mxQb8vX-OB0BXqSCWss5ocONod72RLxHIkYP1kn5W2Mt-2gfHuXDkJZyrgqrsB4kuY5ERuPAYh8MFwT1ov8MMvsmClZQeVXXfFpc_DvHMEbLrazSrdljssBoTY7qhSI6Ah--NFbtEltsMHNnUCWiUVxRWwfDN2rOYrk5w3mYMz9Wr2gihUScvAdlGFqSYB2bvwtPQ

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
            title: Text('Rankings'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
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
                    Navigator.pop(context);
                  },
                )
              : Text("")),
        ],
      ),
    );
  }
}
