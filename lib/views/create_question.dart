import 'package:flutter/material.dart';
import 'package:quiz_app/helpers/functions.dart';
import 'package:quiz_app/models/categoryModel.dart';
import 'package:quiz_app/models/questionModel.dart';
import 'package:quiz_app/server/requests.dart';
import 'package:quiz_app/widgets/widgets.dart';

class CreateQuestion extends StatefulWidget {
  final List<CategoryModel> categories;

  CreateQuestion(this.categories);

  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  CategoryModel currentCategory;
  int categoryId = 0;
  final _formKey = GlobalKey<FormState>();
  String questionTitle, correctAnswer, questionId;
  List<dynamic> answers = ['Answer1', 'Answer2', 'Answer3', 'Answer4'];
  bool _isLoading = false;
  String email;

  createQuestion() async {

    setState(() {
      _isLoading = true;
    });
    if(_formKey.currentState.validate()) {
      QuestionModel question = new QuestionModel();
      question.questionTitle = questionTitle;
      question.answers = answers;
      question.correctAnswer = correctAnswer;
      question.categoryId = currentCategory.categoryId.toString();
      question.approved = false;
      question.userEmail = email;
      await createPendingQuestion(question).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  void initState() {
    setState(() {
      currentCategory = widget.categories[0];
    });
    HelperFunctions.getUserEmail().then((value) {
      setState(() {
        email = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context, "CreateQuestion"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: _isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<CategoryModel>(
                        value: currentCategory,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 20,
                        elevation: 16,
                        style: TextStyle(fontSize: 20, color: Colors.green),
                        onChanged: (CategoryModel newValue) {
                          setState(() {
                            currentCategory = newValue;
                          });
                        },
                        items: widget.categories
                            .map<DropdownMenuItem<CategoryModel>>((CategoryModel value) {
                          return DropdownMenuItem<CategoryModel>(
                            value: value,
                            child: Text(value.categoryName),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Question" : null;
                      },
                      decoration: InputDecoration(hintText: "Question"),
                      onChanged: (val) {
                        questionTitle = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Answer 1" : null;
                      },
                      decoration:
                          InputDecoration(hintText: "Answer 1 (Correct)"),
                      onChanged: (val) {
                        answers[0] = val.toString();
                        correctAnswer = val.toString();
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Answer 2" : null;
                      },
                      decoration: InputDecoration(hintText: "Answer 2"),
                      onChanged: (val) {
                        answers[1] = val.toString();
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Answer 3" : null;
                      },
                      decoration: InputDecoration(hintText: "Answer 3"),
                      onChanged: (val) {
                        answers[2] = val.toString();
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Answer 4" : null;
                      },
                      decoration: InputDecoration(hintText: "Answer 4"),
                      onChanged: (val) {
                        answers[3] = val.toString();
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        createQuestion();
                      },
                      child: buttonGreen(context, 'Add Question'),
                    ),
                    /*SizedBox(height: 6),
                    GestureDetector(
                      onTap: () {
                        databaseService.getCategories();
                      },
                      child: buttonGreen(context, 'Get Categories'),
                    ),*/
                    SizedBox(height: 60)
                  ],
                ),
              ),
            ),
    );
  }
}
