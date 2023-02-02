import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../component/constent.dart';
import '../component/icon_content.dart';
import 'results_page.dart';
import '../component/reusable_card.dart';
import 'package:bmi_calculator/calculator_brain.dart';

const BottomContainerHeigth = 80.0;
const BottomContainerColor = Color(0xFFEB1555);
const ActiveCardColor = Color(0xFF1D1E33);
const inActiveCardColor = Color(0xFF111328);

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int height = 180;
  int weight = 60;
  int age = 20;

  Color maleCardColor = inActiveCardColor;
  Color femaleCardColor = inActiveCardColor;

  void updateColor(int gender) {
    if (gender == 1) {
      if (maleCardColor == inActiveCardColor) {
        maleCardColor = ActiveCardColor;
        femaleCardColor = inActiveCardColor;
      } else {
        maleCardColor = inActiveCardColor;
      }
    }
    // 2 is female
    if (gender == 2) {
      if (femaleCardColor == inActiveCardColor) {
        femaleCardColor = ActiveCardColor;
        maleCardColor = inActiveCardColor;
      } else {
        femaleCardColor = inActiveCardColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: const Color(0xFF0A0E21),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    updateColor(1);
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updateColor(2);
                    });
                  },
                  child: ReusableCard(
                    colour: maleCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: "MALE",
                    ),
                  ),
                ),
              )),
              Expanded(
                  child: ReusableCard(
                colour: femaleCardColor,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.venus,
                  label: "FEMALE",
                ),
              )),
            ],
          )),
          Expanded(
              child: ReusableCard(
            colour: ActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'HEIGHT',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF8D8E98),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      height.toString(),
                      style: knumberTextStyle,
                    ),
                    Text(
                      'cm',
                      style: klabelTextStyle,
                    ),
                  ],
                ),
                Slider(
                  value: height.toDouble(),
                  min: 120.0,
                  max: 220.0,
                  activeColor: Color(0xFFEB1555),
                  inactiveColor: Color(0xFF8D8E98),
                  onChanged: (double newValue) {
                    setState(() {
                      height = newValue.round();
                    });
                  },
                ),
              ],
            ),
          )),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: ReusableCard(
                colour: ActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'WEIGHT',
                      style: klabelTextStyle,
                    ),
                    Text(
                      weight.toString(),
                      style: knumberTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                            child: Icon(
                              FontAwesomeIcons.minus,
                              color: Colors.white,
                            ),
                            backgroundColor: Color(0xFF4C4F5E),
                            onPressed: () {
                              setState(() {
                                weight--;
                              });
                            }),
                        SizedBox(
                          width: 10.0,
                        ),
                        FloatingActionButton(
                            child: Icon(
                              FontAwesomeIcons.plus,
                              color: Colors.white,
                            ),
                            backgroundColor: Color(0xFF4C4F5E),
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              )),
              Expanded(
                child: ReusableCard(
                    colour: ActiveCardColor,
                    cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style: klabelTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: knumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                  child: Icon(
                                    FontAwesomeIcons.plus,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Color(0xFF4C4F5E),
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                              FloatingActionButton(
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Color(0xFF4C4F5E),
                                  onPressed: () {
                                    setState(() {
                                      age--;
                                    });
                                  }),
                            ],
                          ),
                        ])),
              )
            ],
          )),
          GestureDetector(
            onTap: () {

              CalculatorBrain calc= CalculatorBrain(height: height, weight: weight);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => resultsPage(
                    resulttext:calc.getResult(),
                    bmiResult: calc.CalculatBMI(),
                    interpretitation: calc.getInterpretitation(),
                  )));
            },
            child: Container(
              child: Center(
                  child: Text(
                'CALCULATOR',
                style: KlergeTextButtomStyle,
              )),
              color: BottomContainerColor,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 80.0,
            ),
          ),
        ],
      ),
    );
  }
}


