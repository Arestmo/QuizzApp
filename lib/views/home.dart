import 'package:flutter/material.dart';
import 'package:quiz_app/models/categoryModel.dart';
import 'package:quiz_app/server/requests.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/create_question.dart';
import 'package:quiz_app/views/playquiz.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = new AuthService();
  List<CategoryModel> allCategories;

  @override
  void initState() {

    super.initState();
    getAllCategories().then((value) {
      setState(() {
        allCategories = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context, "ChoseQuiz"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.green,
              ),
              onPressed: () {
                authService.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              })
        ],
        iconTheme: IconThemeData(color: Colors.green),
      ),
      drawer: NavDrawer(),
      body: CategoriesTiles(allCategories),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateQuestion(allCategories)));
        },
      ),
    );
  }
}

class QuizTitle extends StatefulWidget {
  final String imgUrl;
  final String title;
  final int id;


  QuizTitle({@required this.imgUrl, @required this.title, @required this.id});


  @override
  _QuizTitleState createState() => _QuizTitleState();
}

class _QuizTitleState extends State<QuizTitle> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayQuiz(
                      categoryId: widget.id,
                    )));
      },
      child: Container(
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
                widget.title,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesTiles extends StatelessWidget {
  final List<CategoryModel> categories;

  CategoriesTiles(this.categories);

  @override
  Widget build(BuildContext context) {
    return categories != null
        ? ListView.builder(
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return new QuizTitle(
                title: categories[index].categoryName,
                imgUrl: categories[index].categoryUrl,
                id: categories[index].categoryId,
              );
            })
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
