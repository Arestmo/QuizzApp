import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/helpers/functions.dart';
import 'package:quiz_app/models/categoryModel.dart';
import 'package:quiz_app/models/questionModel.dart';
import 'package:quiz_app/models/topusersModel.dart';

String _serverPath = "http://192.168.0.23:8085/questiongame/api";

Future<List<CategoryModel>> getAllCategories() async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;
    final response = await http.get('$_serverPath/category/getlist', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var categoryObjects = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      List<CategoryModel> categoryJsons = categoryObjects
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();
      return categoryJsons;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load categories');
    }
  });
}

Future<List<QuestionModel>> getQuestionByCategoryId(
    int categoryId, int numberOfQuestion) async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;
    final response = await http.get(
        '$_serverPath/question/random/$categoryId/$numberOfQuestion',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var questionsObjects =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;
      List<QuestionModel> questionJsons = questionsObjects
          .map((questionJson) => QuestionModel.fromJson(questionJson))
          .toList();
      return questionJsons;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load questions');
    }
  });
}

Future<http.Response> createPendingQuestion(QuestionModel question) async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;

    final response = await http.post(
      '$_serverPath/question/add',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "question": question.questionTitle,
        "responseA": question.answers[0],
        "responseB": question.answers[1],
        "responseC": question.answers[2],
        "responseD": question.answers[3],
        "correct": question.correctAnswer,
        "categoryId": question.categoryId,
        "userEmail": question.userEmail,
        "approved": false
      }),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Filed to add question');
    }
  });
}

Future<http.Response> approvePendingQuestion(QuestionModel question) async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;

    final response = await http.put(
      '$_serverPath/question/update',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "questionId": question.questionId,
        "question": question.questionTitle,
        "responseA": question.answers[0],
        "responseB": question.answers[1],
        "responseC": question.answers[2],
        "responseD": question.answers[3],
        "correct": question.correctAnswer,
        "categoryId": question.categoryId,
        "userEmail": question.userEmail,
        "approved": true
      }),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Filed to approve question');
    }
  });
}

Future<http.Response> deleteQuestion({int questionId}) async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;

    final response = await http
        .delete('$_serverPath/question/delete/$questionId', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Filed to delete question');
    }
  });
}

Future<List<QuestionModel>> getPendingQuestions(String userEmail) async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;
    final response = await http
        .get('$_serverPath/question/getUserList/$userEmail', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var questionsObjects =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;
      List<QuestionModel> questionJsons = questionsObjects
          .map((questionJson) => QuestionModel.fromJson(questionJson))
          .toList();
      return questionJsons;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load pending questions');
    }
  });
}

Future<List<QuestionModel>> getQuestionsToApprove() async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;
    final response =
        await http.get('$_serverPath/question/getlistPending', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var questionsObjects =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;
      List<QuestionModel> questionJsons = questionsObjects
          .map((questionJson) => QuestionModel.fromJson(questionJson))
          .toList();
      return questionJsons;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load questions to approve');
    }
  });
}

Future<double> getUserStats(
    String userEmail, String categoryId, int days) async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;
    final response = await http.get(
        '$_serverPath/game/userstats/$userEmail/$categoryId/$days',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var responseData = jsonDecode(response.body) as double;
      return responseData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to user Stats');
    }
  });
}

Future<List<TopUsersModel>> getTopUsers() async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;
    final response = await http.get('$_serverPath/game/userrank/10', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var topUsersObjects = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      List<TopUsersModel> topUsersJsons = topUsersObjects
          .map((questionJson) => TopUsersModel.fromJson(questionJson))
          .toList();
      return topUsersJsons;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load top users');
    }
  });
}

Future<http.Response> pushCompletedQuiz(
    {int correctAnswers,
    int nofQuestions,
    String userEmail,
    String categoryId}) async {
  String token;
  return HelperFunctions.getUserToken().then((value) async {
    token = value;

    final response = await http.post(
      '$_serverPath/game/add',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "correctAnswers": correctAnswers,
        "numberOfQuestions": nofQuestions,
        "userEmail": userEmail,
        "categoryId": categoryId,
      }),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Filed to add completed quiz');
    }
  });
}
