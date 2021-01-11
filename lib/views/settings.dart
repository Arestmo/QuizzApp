import 'package:flutter/material.dart';
import 'package:quiz_app/helpers/functions.dart';
import 'package:quiz_app/widgets/widgets.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _numberOfQuestionPerGame = 10;
  int _difficultyLevel = 1;

  void _handleNumberOfQuestionPerGameChange(int value) {
    setState(() {
      _numberOfQuestionPerGame = value;
      HelperFunctions.setQuestionPerGame(
          quesionsPerGame: _numberOfQuestionPerGame);
    });
  }

  void _handleDifficultyLevelChange(int value) {
    setState(() {
      _difficultyLevel = value;
    });
  }

  @override
  void initState() {
    HelperFunctions.getQuestionPerGame().then((value) {
      setState(() {
        _numberOfQuestionPerGame = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context, "AppSettings"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Number of question per game",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio(
                    value: 10,
                    groupValue: _numberOfQuestionPerGame,
                    onChanged: _handleNumberOfQuestionPerGameChange),
                new Text(
                  "10",
                  style: TextStyle(fontSize: 18),
                ),
                new Radio(
                    value: 20,
                    groupValue: _numberOfQuestionPerGame,
                    onChanged: _handleNumberOfQuestionPerGameChange),
                new Text("20",
                  style: TextStyle(fontSize: 18),),
                new Radio(
                    value: 30,
                    groupValue: _numberOfQuestionPerGame,
                    onChanged: _handleNumberOfQuestionPerGameChange),
                new Text("30",
                  style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Difficulty Level",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio(
                    value: 1,
                    groupValue: _difficultyLevel,
                    onChanged: _handleDifficultyLevelChange),
                new Text("Easy",
                  style: TextStyle(fontSize: 18),),
                new Radio(
                    value: 2,
                    groupValue: _difficultyLevel,
                    onChanged: _handleDifficultyLevelChange),
                new Text("Normal",
                  style: TextStyle(fontSize: 18),),
                new Radio(
                    value: 3,
                    groupValue: _difficultyLevel,
                    onChanged: _handleDifficultyLevelChange),
                new Text("Hard",
                  style: TextStyle(fontSize: 18),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
