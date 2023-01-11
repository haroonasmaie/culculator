import 'package:flutter/material.dart';
import "package:math_expressions/math_expressions.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String exper = "";
  double equsize = 40;
  double resultsize = 30;

  buttonpress(String txtbtn) {
    setState(() {
      if (txtbtn == "c") {
        equsize = 40;
        resultsize = 30;
        equation = "0";
        result = "0";
      } else if (txtbtn == "<-") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (txtbtn == "=") {
        equsize = 30;
        resultsize = 40;
        exper = equation;
        exper = exper.replaceAll("÷", "/");
        exper = exper.replaceAll("×", "*");
        try {
          Parser p = Parser();
          Expression exp = p.parse(exper);

          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "error";
        }
      } else {
        if (equation == "0") {
          equation = txtbtn;
        } else {
          equation += txtbtn;
        }
      }
    });
  }

  Widget buttonswidget(String txt, Color backcolor) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 0.5)),
        height: MediaQuery.of(context).size.height * 0.1,
        child: TextButton(
          onPressed: () => buttonpress(txt),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backcolor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Text(txt,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Simple Calculator"))),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(equation, style: TextStyle(fontSize: equsize)),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(result, style: TextStyle(fontSize: resultsize)),
          ),
          const Spacer(),
          Row(
            children: [
              buttonswidget("c", Colors.red),
              buttonswidget("%", Colors.black12),
              buttonswidget("÷", Colors.black12),
              buttonswidget("<-", Colors.black12),
            ],
          ),
          Row(
            children: [
              buttonswidget("7", Colors.black12),
              buttonswidget("8", Colors.black12),
              buttonswidget("9", Colors.black12),
              buttonswidget("×", Colors.black12),
            ],
          ),
          Row(
            children: [
              buttonswidget("4", Colors.black12),
              buttonswidget("5", Colors.black12),
              buttonswidget("6", Colors.black12),
              buttonswidget("-", Colors.black12),
            ],
          ),
          Row(
            children: [
              buttonswidget("1", Colors.black12),
              buttonswidget("2", Colors.black12),
              buttonswidget("3", Colors.black12),
              buttonswidget("+", Colors.black12),
            ],
          ),
          Row(
            children: [
              buttonswidget("00", Colors.black12),
              buttonswidget("0", Colors.black12),
              buttonswidget(".", Colors.black12),
              buttonswidget(
                "=",
                Colors.blue,
              ),
            ],
          )
        ],
      ),
    );
  }
}
