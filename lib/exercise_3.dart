import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Exercise3 extends StatefulWidget {
  const Exercise3({Key? key}) : super(key: key);

  @override
  State<Exercise3> createState() => _Exercise3State();
}

class _Exercise3State extends State<Exercise3> {

  String userInput = '';
  String answer = '';

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 - Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget> [
          Expanded(
            child: Container(
              child: Column(
                children: <Widget> [
                  Container(
                    padding: const EdgeInsets.all(25),
                    alignment: Alignment.centerRight,
                    child: Text(userInput, style: const TextStyle(fontSize: 25, color: Colors.black),),
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    alignment: Alignment.centerRight,
                    child: Text(answer, style: const TextStyle(fontSize: 30, color: Colors.black),),
                  )
                ],
              )
            )
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0){
                    return Button(
                      buttontapped: () {
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[100],
                      textColor: Colors.black,
                    );
                  }else if(index == 1){
                    return Button(
                      buttonText: buttons[index],
                      color: Colors.blue[100],
                      textColor:Colors.black,
                    );
                  }else if(index == 2) {
                    return Button(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[100],
                      textColor: Colors.black,
                    );
                  }else if(index == 3) {
                    return Button(
                      buttontapped: () {
                        setState(() {
                          userInput = userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[100],
                      textColor: Colors.black,
                    );
                  }else if(index == 18){
                    return Button(
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orange[700],
                      textColor: Colors.white,
                    );
                  }else {
                    return Button(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.black
                          : Colors.lightGreenAccent,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                    );
                  }
                },
              )
            )
          )
        ],
      ),
    );
  }
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

class Button extends StatelessWidget {

  // declaring variables
  final color;
  final textColor;
  String buttonText;
  final buttontapped;

  //Constructor
  Button({this.color, this.textColor, required this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}