import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Random Numbers Game",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController randomController = TextEditingController();

  int? randomNumber;
  int? guessedNumber;
  String textShow = "";
  int? counter = 0;
  bool? isWin;

  OutlineInputBorder borderDesign(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  guessNumber() {
    if (counter! <= 3) {
      if (randomNumber == guessedNumber) {
        setState(() {
          textShow =
              "تخمينك صحيح الرقم هو $randomNumber لقد نجحت بعد${counter!} محاولة";
          isWin = true;
        });
      } else {
        if (randomNumber! > guessedNumber!) {
          setState(() {
            textShow = "خمن رقم أكبر";
          });
        } else {
          setState(() {
            textShow = "خمن رقم أقل";
          });
        }
      }
    } else {
      setState(() {
        textShow = "لقد خسرت حاول مرة اخرى";
        isWin = false;
      });
    }
  }

  Widget myText(String text) {
    var didWin;
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 30,
            color: isWin == null
                ? Colors.black
                : isWin == false
                    ? Colors.red
                    : Colors.cyan,
            fontFamily: "Vazirmatn"));
  }

  @override
  void initState() {
    super.initState();
    randomNumber = Random().nextInt(9) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "لعبة خمن الأرقام",
            style: TextStyle(fontFamily: "Vazirmatn"),
          )),
      // ignore: prefer_const_literals_to_create_immutables
      body: Form(
        key: _formKey,
        child: Column(children: [
          const SizedBox(height: 66),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: myText(
                guessedNumber == null
                    ? "خمن رقم من 1 الي 10 لديك ثلاث محاولات"
                    : textShow,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "أدخل رقم للتخمين";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                guessedNumber = int.parse(value);
              },
              controller: randomController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusedBorder: borderDesign(Colors.cyan),
                errorBorder: borderDesign(Colors.red),
                enabledBorder: borderDesign(Colors.black),
                disabledBorder: borderDesign(Colors.black),
                focusedErrorBorder: borderDesign(Colors.red),
                hintText: "خمن الرقم",
                hintTextDirection: TextDirection.rtl,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      counter = counter! + 1;
                      guessNumber();
                    }
                  },
                  child: const Text(
                    "خمن",
                    style: TextStyle(fontFamily: "Vazirmatn", fontSize: 18),
                  )),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          guessedNumber = null;
                          randomNumber = Random().nextInt(9) + 1;
                          counter = 0;
                          randomController.clear();
                          isWin = null;
                        });
                      },
                      child: const Text(
                        "أعد اللعبة",
                        style: TextStyle(fontFamily: "Vazirmatn", fontSize: 18),
                      )),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
