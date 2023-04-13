import 'dart:math' as math;
import 'dart:developer' as dp;
import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  @override
  void initState() {
    var val = doCalculation('5*5=');
    dp.log(val);
    // TODO: implement initState
    super.initState();
  }

  String doCalculation(String inval) {
    Parser p = Parser();
    inval = inval.replaceAll("x", "*");
    if (inval.contains('=')) {
      dp.log('true');
      inval = inval.substring(0, inval.length - 1);
    }
    Expression exp = p.parse(inval);
    dp.log(exp.toString());
    ContextModel cm = ContextModel();
    var finalValue = exp.evaluate(EvaluationType.REAL, cm);
    dp.log(finalValue.toString());
    return finalValue.toString();
  }
  // creating the variables

  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;
  onButtonClick(value) {
    // if value given is AC
    dp.log(value.toString());

    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        dp.log(input);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        dp.log('input before function=$input');
        input = doCalculation(input);
        dp.log('input after function=$input');
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          // Input and Output area section
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),

          // buttons area for calculator
          Row(
            children: [
              button(
                  text: "AC",
                  buttonBgColor: operatorColor,
                  tColor: orangeColor),
              button(
                  text: "<", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "", buttonBgColor: Colors.transparent),
              button(
                  text: "/", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),

          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "x", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(
                  text: "%", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "0"),
              button(text: "."),
              button(
                  text: "=", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(22),
              backgroundColor: buttonBgColor),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
