import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:QuizApp/widget/text_utils.dart';
import 'package:QuizApp/models/question.dart';
//import 'package:flutter/services.dart';

class QuizzPage extends StatefulWidget {
  @override
  _QuizzPageState createState() => new _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  /*List<Question> questions = new List<Question>();
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/questions.json");
  }

  Future parseJson() async {
    String jsonString = await _loadFromAsset();
    final jsonResponse = jsonDecode(jsonString);
    if (questions.length == 0) {
      for (var item in jsonResponse) {
        this.questions.add(new Question(item['question'], item['response'],
            item['explaination'], item['imagePath']));
      }
    }
    print(questions[0].explaination);
  }*/

  Question question;
  List<Question> questionsList = [
    new Question("Paris est la capitale de la France ?", true,
        "Et oui ! Paris est bien la capitale de la france", "paris.jpg"),
    new Question("Les BCAA sont des acides aminés essentiels en Musculation ?",
        true, "BCAA aide à la recupération musculaire.. :D", "bcaa.jpg"),
    new Question("Limoges est la plus grande ville du monde ?", false,
        "C'est pas trés grand Limoges, ahah!", "limoges.jpg"),
    new Question("La lune est une planète ?", false,
        "C'est le satellite naturel de la terre", "lune.jpg"),
    new Question("Twitter est le réseau social le plus utilisé ?", false,
        "Ce n'était pas lui!", "twitter.jpg"),
    new Question("Flutter est un langage de programmation ?", false,
        "Flutter est un kit de développement, un Framework", "flutter.jpg"),
    new Question("Minecraft est un jeu vidéo ?", true, "Un jeu trés cubique!",
        "minecraft.jpg"),
    new Question("Lucifer est une serie original Netflix", true,
        "La serie a été rachetée par Netflix", "lucifer.jpg"),
    new Question("Louis XVI s'est suicidé", false,
        "Il s'est pas suicidé mais il aurit dû!", "louisxvi.jpg"),
    new Question("Les prochains JO seront à Paris ?", true,
        "Oui, ce sera en 2024!", "jo.jpg")
  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    question = questionsList[index];
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.5;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new TextUtils(
          "Quizz | Partie",
          color: Colors.white,
        ),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new TextUtils("Question n°${index + 1}"),
            new TextUtils("Score: $score / ${index + 1}"),
            new Card(
              elevation: 8,
              child: new Container(
                height: size,
                width: size,
                child: new Image.asset(
                  'assets/' + question.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new TextUtils(
              question.question,
              textscaleFactor: 1.3,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                raisedButton(true),
                raisedButton(false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  RaisedButton raisedButton(bool b) {
    return RaisedButton(
      onPressed: () => dialog(b),
      elevation: 8,
      color: Colors.green,
      child: TextUtils(
        b ? "Vrai" : "Faux",
        color: Colors.white,
      ),
    );
  }

  Future<Null> dialog(bool b) async {
    bool rightAnwser = (b == question.response);
    String good = "assets/true.png";
    String bad = "assets/false.png";

    if (rightAnwser) {
      score++;
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          title: new TextUtils(
            rightAnwser ? "Bravo !" : "Dommage !",
            textscaleFactor: 1.4,
            color: rightAnwser ? Colors.green : Colors.redAccent,
          ),
          contentPadding: EdgeInsets.all(10),
          children: <Widget>[
            Image.asset(
              rightAnwser ? good : bad,
              fit: BoxFit.cover,
            ),
            Container(
              height: 20,
            ),
            TextUtils(
              question.explaination,
              textscaleFactor: 1.1,
              color: Colors.grey[900],
            ),
            Container(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                getNextQuestions();
              },
              color: Colors.green,
              child: TextUtils(
                'Question Suivante',
                color: Colors.white,
                textscaleFactor: 1.2,
              ),
            )
          ],
        );
      },
    );
  }

  Future<Null> alert() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: TextUtils(
            "Fin du Quizz",
            color: Colors.deepPurpleAccent,
            textscaleFactor: 1.2,
          ),
          contentPadding: EdgeInsets.all(10),
          content: TextUtils(
            "Votre Score : $score / ${index + 1}",
            color: Colors.grey[900],
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(buildContext);
                  Navigator.pop(context);
                },
                child: TextUtils(
                  "Terminé",
                  textscaleFactor: 1.4,
                  color: Colors.deepPurpleAccent,
                )),
          ],
        );
      },
    );
  }

  void getNextQuestions() {
    if (index < questionsList.length - 1) {
      index++;
      setState(() {
        question = questionsList[index];
      });
    } else {
      alert();
    }
  }
}
