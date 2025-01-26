import 'package:flutter/material.dart';
import 'question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  /*
  question1: 'You can lead a cow down stairs but not up stairs.', false,
  question2: 'Approximately one quarter of human bones are in the feet.', true,
  question3: 'A slug\'s blood is green.', true,
  */

  List<Question> questions = [
    Question(questionText: "You can lead a cow down stairs but not up stairs.", questionAnswer: false),
    Question(questionText: "Approximately one quarter of human bones are in the feet.", questionAnswer: true),
    Question(questionText: "A slug's blood is green.", questionAnswer: true),
  ];

  List<Icon> scoreKeeper = []; // 下方紀錄

  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[questionIndex].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ), // 問題
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'true',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                // 判斷答案是否正確
                bool rightAnswer = questions[questionIndex].questionAnswer;

                if (rightAnswer) {
                  print("you are right!");
                } else {
                  print("you are wrong!");
                }

                setState(() {
                  questionIndex = questionIndex + 1; // 下個問題
                  scoreKeeper.add(
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  );
                });
              },
            ),
          ),
        ), // 按鈕是
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                // 判斷答案是否正確
                bool rightAnswer = questions[questionIndex].questionAnswer;

                if (!rightAnswer) {
                  print("you are right!");
                } else {
                  print("you are wrong!");
                }

                setState(() {
                  questionIndex = questionIndex + 1; // 下個問題
                  scoreKeeper.add(Icon(
                    Icons.close,
                    color: Colors.red,
                  ));
                });
              },
            ),
          ),
        ), // 按鈕否
        Row(
          children: scoreKeeper, // 下方紀錄
        )
      ],
    );
  }
}
