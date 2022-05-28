import 'package:carousel_slider/carousel_slider.dart';
import 'package:currency_converter/APIcalls/api_functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utilities/utilities.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController amountTEC = TextEditingController();
  var convertedValue = 0;

  List currencies = [
    'USD'
        'EUR'
        'AUD'
  ];

  @override
  void dispose() {
    amountTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: mainC,
      appBar: AppBar(
        backgroundColor: mainCAlt,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          /* physics: const NeverScrollableScrollPhysics(), */
          children: [
            SizedBox(
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: currencies.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                      child: Text(currencies[itemIndex].toString()),
                    ),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                          /* color: Colors.pinkAccent, */
                          /* height: 15.h, */
                          /* width: 50.w, */
                          child: TextField(
                        textAlign: TextAlign.center,
                        showCursor: false,
                        style: const TextStyle(fontSize: 40, color: salmonPink),
                        enableInteractiveSelection: false,
                        controller: amountTEC,
                        decoration: const InputDecoration(
                            border: InputBorder.none,

                            //later should be
                            hintText: 'Amount',
                            hintStyle: TextStyle(
                                color: salmonPink,
                                fontWeight: FontWeight.bold)),
                      )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      converterButton('Convert'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      convertedValue.toString(),
                      style: const TextStyle(color: salmonPink, fontSize: 50),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget converterButton(String text) {
    return GestureDetector(
      onTap: () {
        APIFunctions().fetchCurrency();
      },
      child: Container(
        decoration: const BoxDecoration(
            color: salmonPink,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 10.h,
        width: 30.w,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: navyBlue, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
