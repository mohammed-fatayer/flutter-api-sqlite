import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

GlobalKey<FormState> formkey = GlobalKey<FormState>();
int selectedValue = 0;
double firstNum = 0, secondNum = 0, result = 0;

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("claculator"),
        ),
        body: Center(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "pease enter some numbers";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (vlaue) {
                      firstNum = double.parse(vlaue!);
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "pease enter some numbers";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (vlaue) {
                      secondNum = double.parse(vlaue!);
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text("$result"),
                const SizedBox(
                  height: 50,
                ),
                DropdownButton(
                    value: selectedValue,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("please select operator"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("+"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("-"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("/"),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text("*"),
                      ),
                    ],
                    onChanged: (value) {
                      selectedValue = int.parse("$value");
                      setState(() {});
                    }),
                ElevatedButton(
                    onPressed: () {
                      if (selectedValue == 0) {
                      } else {
                        var formndata = formkey.currentState;
                        if (formndata!.validate()) {
                          formndata.save();
                        }

                        switch (selectedValue) {
                          case 1:
                            result = firstNum + secondNum;
                            break;
                          case 2:
                            result = firstNum - secondNum;
                            break;
                          case 3:
                            result = firstNum / secondNum;
                            break;
                          case 4:
                            result = firstNum * secondNum;
                            break;
                          default:
                        }
                        setState(() {});
                      }
                    },
                    child: const Text("Calculate")),
              ],
            ),
          ),
        ));
  }
}
