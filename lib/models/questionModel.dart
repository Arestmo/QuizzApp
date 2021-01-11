class QuestionModel {
  String questionTitle;
  List<dynamic> answers;
  String correctAnswer;
  int questionId;
  String categoryId;
  String userEmail;
  bool approved;
  bool answered;
  bool answeredCorrect;

  QuestionModel({
    this.questionTitle,
    this.answers,
    this.questionId,
    this.answered,
    this.correctAnswer,
    this.categoryId,
    this.approved,
    this.userEmail,
    this.answeredCorrect,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      questionId: json['questionId'],
      questionTitle: json['question'],
      answers: [json['responseA'],json['responseB'],json['responseC'],json['responseD'],],
      correctAnswer: json['correct'],
      categoryId: json['categoryId'],
      userEmail: json['userEmail'],
      approved: json['approved'],
      answered: false,
      answeredCorrect: false,

    );
  }
}
