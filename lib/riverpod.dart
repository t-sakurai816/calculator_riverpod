import 'package:calculator_riverpod/model/calculator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, Calculator>(
        (ref) => CalculatorNotifier());

class CalculatorNotifier extends StateNotifier<Calculator> {
  CalculatorNotifier() : super(Calculator());

  void append(String buttonText) {
    final equation = () {
      return state.equation == '0' ? buttonText : state.equation + buttonText;
    }();

    state = state.copy(equation: equation);
  }
}
