import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String displayText = ''; // 현재 나타나는 숫자
  String operation = ''; // 계산해야 할 수식

  void updateDisplay(String value) {
    setState(() {
      if (value == 'AC') { // 초기화
        displayText = '';
        operation = '';

      } else if (value == '+/-') { // 양수 음수 전환 버튼
        if (displayText.isNotEmpty) {
          if (displayText.startsWith('-')) {
            displayText = displayText.substring(1);
          } else {
            displayText = '-' + displayText;
          }
        }
      } else if (value == '=') {  // 결과 값 호출 버튼
        if (operation.isNotEmpty && displayText.isNotEmpty) {
          operation += displayText;
          final result = evaluateExpression(operation); // 호출 시점
          displayText = result.toString();
          operation = '';

        }
      } else if (value == '+' || value == '-' || value == 'X' || value == '/' || value == '%') { // 연산자 기호 클릭 시
        if (displayText.isNotEmpty) {
          operation += displayText + ' ' + (value == 'X' ? '*' : value) + ' '; // X면 *로 변환 나머지는 value 그대로 저장
          displayText = '';
        }
      } else { // 숫자 이어서 입력
        displayText += value;
      }
    });
  }

  double evaluateExpression(String value) {
  List<String> expression = value.split(' '); // 요소 값들을 ' ' 기준으로 나눠 배열에 담음 

  // 곱셈, 나눗셈, 나머지 연산자 우선 처리
  for (int i = 1; i < expression.length; i += 2) {
    String str = expression[i];
    double nextNumber = double.parse(expression[i + 1]);

    if (str == '*' || str == '/' || str == '%') {
      if (str == '*') {
        expression[i - 1] = (double.parse(expression[i - 1]) * nextNumber).toString();
      } else if (str == '/') {
        if (nextNumber != 0) {
          expression[i - 1] = (double.parse(expression[i - 1]) / nextNumber).toString();
        }
      } else if (str == '%') {
        expression[i - 1] = (double.parse(expression[i - 1]) % nextNumber).toString();
      }
      expression.removeAt(i); // 연산자 기호 제거
      expression.removeAt(i); // 기호 다음 숫자 제거
      i -= 2; // 삭제한 만큼 다시 인덱스를 앞으로 이동
    }
  }

  // 덧셈과 뺄셈을 처리
  double result = double.parse(expression[0]);
  for (int i = 1; i < expression.length; i += 2) {
    String str = expression[i];
    double nextNumber = double.parse(expression[i + 1]);

    switch (str) {
      case '+':
        result += nextNumber;
        break;
      case '-':
        result -= nextNumber;
        break;
    }
  }

  return result;
}


  void pushDotBtn() { // '.' 버튼 클릭 시 
    if (!displayText.contains('.')) {
      setState(() {
        displayText += '.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('계산기'),
          backgroundColor: Colors.brown,
        ),

        body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.black,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                color: Colors.white,
                width: double.infinity,
                height: 80,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    displayText,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
              Row( // 1행
                children: [
                  buildButton('AC', () => updateDisplay('AC')),
                  buildButton('+/-', () => updateDisplay('+/-')),
                  buildButton('%', () => updateDisplay('%')),
                  buildButton('/', () => updateDisplay('/')),
                ],
              ),
              Row( // 2행
                children: [
                  buildButton('7', () => updateDisplay('7')),
                  buildButton('8', () => updateDisplay('8')),
                  buildButton('9', () => updateDisplay('9')),
                  buildButton('X', () => updateDisplay('X')),
                ],
              ),
              Row( // 3행
                children: [
                  buildButton('4', () => updateDisplay('4')),
                  buildButton('5', () => updateDisplay('5')),
                  buildButton('6', () => updateDisplay('6')),
                  buildButton('-', () => updateDisplay('-')),
                ],
              ),
              Row( // 4행
                children: [
                  buildButton('1', () => updateDisplay('1')),
                  buildButton('2', () => updateDisplay('2')),
                  buildButton('3', () => updateDisplay('3')),
                  buildButton('+', () => updateDisplay('+')),
                ],
              ),
              Row( // 5행
                children: [
                  buildButton('0', () => updateDisplay('0'), flex: 2), // '0' 버튼은 가로로 2칸 차지
                  buildButton('.', () => pushDotBtn()),
                  buildButton('=', () => updateDisplay('=')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String text, VoidCallback onPressed, {int flex = 1}) {
    return Flexible(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(5),
        color: Colors.grey,
        height: 100,
        child: Center(
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(),
            child: Text(
              text,
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
