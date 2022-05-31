/* import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class KeyBoard extends StatefulWidget {
  const KeyBoard({Key? key}) : super(key: key);

  @override
  State<KeyBoard> createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  @override
  Widget build(BuildContext context) {
    return NumericKeyboard(
        onKeyboardTap: _onKeyboardTap,
        textColor: Colors.red,
        rightButtonFn: () {
          setState(() {
            text = text.substring(0, text.length - 1);
          });
        },
        rightIcon: Icon(
          Icons.backspace,
          color: Colors.red,
        ),
        leftButtonFn: () {
          print('left button clicked');
        },
        leftIcon: Icon(
          Icons.check,
          color: Colors.red,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly);
  }
}
 */