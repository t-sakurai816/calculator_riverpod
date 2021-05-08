import 'package:calculator_riverpod/utils.dart';
import 'package:calculator_riverpod/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final VoidCallback onClickedLong;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.onClickedLong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fontSize = Utils.isOperator(text, hasEquals: true) ? 26 : 22;
    final style = TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
    return Expanded(
      child: Container(
        height: double.infinity,
        margin: EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: onClicked,
          onLongPress: onClickedLong,
          style: ElevatedButton.styleFrom(
            //ボタンの背景色
            primary: MyColors.background3,
            elevation: 0,
            // ボタンの丸み
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: text == '<'
              //置換する
              ? Icon(Icons.backspace_outlined, color: Colors.white)
              : Text(text, style: style),
        ),
      ),
    );
  }
}
