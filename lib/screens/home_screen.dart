import 'dart:developer';
import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:currency_converter/APIcalls/api_functions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:sizer/sizer.dart';

import '../utilities/utilities.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String baseCurrencyValue = 'USD';
  String selectedCurrencyValue = 'EUR';
  NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
  TextEditingController amountTEC = TextEditingController();
  double convertedValue = 0.00;
  late var ratesData;
/*   var currenciesData = APIFunctions().fetchLocalCurrencyList();
 */
  var currencies = [];
  /*   var localCurrenciesData = APIFunctions().fetchLocalCurrencyList();*/

  @override
  void initState() {
    getLocalCurrencies();

    super.initState();
  }

  @override
  void dispose() {
    amountTEC.dispose();
    super.dispose();
  }

  getLocalCurrencies() async {
    currencies = await APIFunctions().fetchLocalCurrencyList();
    setState(() {});
  }

  convertCurrencies() async {
    ratesData = await APIFunctions().fetchCurrency(
      baseCurrencyValue,
      selectedCurrencyValue,
    );
    setState(() {});
    log('currency data: $ratesData');
    log('${ratesData[selectedCurrencyValue]}');

    return int.parse(amountTEC.text) * ratesData[selectedCurrencyValue];
  }

  Future<void> getListOfCurrencies() async {
    setState(() {
      //getting the list of currencies
      currencies = APIFunctions()
          .fetchCurrency(baseCurrencyValue, selectedCurrencyValue)
          .keys
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: mainCDark,
      /* appBar: AppBar(
        backgroundColor: mainCAltDark,
      ), */
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          /* physics: const NeverScrollableScrollPhysics(), */
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 3,
              child: Column(
                children: [
                  currencies.isEmpty
                      ? Container()
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                /* hint: const Text(
                                  'Select Currency',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: mainCDarkF,
                                  ),
                                ), */
                                items: currencies
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: baseCurrencyValue,
                                style: const TextStyle(color: mainCDarkF),
                                onChanged: (value) {
                                  setState(() {
                                    baseCurrencyValue = value as String;
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth: 10.h,
                                itemHeight: 40,
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 10, right: 10),
                    child: Container(
                        /* color: mainCAltDark, */
                        /* height: 15.h, */
                        /* width: 50.w, */
                        child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      showCursor: false,
                      style: const TextStyle(
                        fontSize: 70,
                        color: Colors.white,
                      ),
                      enableInteractiveSelection: false,
                      controller: amountTEC,
                      decoration: const InputDecoration(
                        border: InputBorder.none,

                        //later should be
                        hintText: '0.00',
                        hintStyle: TextStyle(
                          color: mainCDarkF,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _button('Convert'),
                      _button('convert'),
                    ],
                  ), */
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: mainCAltDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              height: MediaQuery.of(context).size.height * 2 / 3,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          /* hint: const Text(
                                    'Select Currency',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: mainCDarkF,
                                    ),
                                  ), */
                          items: currencies
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedCurrencyValue,
                          style: const TextStyle(color: mainCDarkF),
                          onChanged: (value) {
                            setState(() {
                              selectedCurrencyValue = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 10.h,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        numberFormat.format(convertedValue).toString(),
                        textAlign: TextAlign.right,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 75),
                      ),
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: babyBlueEyes,
                    rightButtonFn: () {
                      setState(() {
                        amountTEC.text = amountTEC.text
                            .substring(0, amountTEC.text.length - 1);
                      });
                    },
                    rightIcon: const Icon(
                      Icons.backspace,
                      color: babyBlueEyes,
                    ),
                    leftButtonFn: () async {
                      await getSpecificCurrency();
                    },
                    leftIcon: const Icon(
                      Icons.check,
                      color: babyBlueEyes,
                    ),
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      amountTEC.text = amountTEC.text + value;
    });
  }

  getSpecificCurrency() async {
    convertedValue = await convertCurrencies();
    setState(() {});
  }

  _button(String text) {
    return GestureDetector(
      onTap: () async {
        await getSpecificCurrency();
      },
      child: Container(
        decoration: const BoxDecoration(
            color: salmonPink,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        height: 7.h,
        width: 30.w,
        child: Center(
            child: Text(
          text,
          style:
              const TextStyle(color: babyBlueEyes, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
