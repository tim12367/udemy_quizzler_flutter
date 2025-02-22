import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// Step 2 - Import the rFlutter_Alert package here.
void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

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
  List<Icon> scoreKeeper = []; // 下方紀錄
  void checkAnswer(bool userPickedAnswer) {
    // 判斷答案是否正確
    bool rightAnswer = quizBrain.getQuestionAnswer();
    bool isFinished = quizBrain.isFinished();

    setState(() {
      // Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      if (isFinished) {
        // Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
        Alert(
          context: context,
          title: "您以回答完問題",
          desc: "按下任意按鈕或關閉，返回第一題",
          style: AlertStyle(
            backgroundColor: Colors.white38,
            titleStyle: TextStyle(color: Colors.white),
            descStyle: TextStyle(color: Colors.white),
          ),
          buttons: [
            DialogButton(
              color: Colors.green,
              child: Text("返回第一題"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ).show();
        // Step 4 Part C - reset the questionNumber,
        quizBrain.reset();
        // Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper.clear();
      } else {
        // Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇
        if (userPickedAnswer == rightAnswer) {
          print("you are right!");
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          print("you are wrong!");
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
        quizBrain.nextQuestion(); // 前往下一題
      }
    });
  }

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
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ), // 問題
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'true',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ), // 按鈕是
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ), // 按鈕否
        Row(
          children: scoreKeeper, // 下方紀錄
        ),
      ],
    );
  }
}
