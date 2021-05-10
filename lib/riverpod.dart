import 'package:calculator_riverpod/model/calculator_model.dart';
import 'package:calculator_riverpod/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorModel>(
        (ref) => CalculatorNotifier());

class CalculatorNotifier extends StateNotifier<CalculatorModel> {
  CalculatorNotifier() : super(CalculatorModel());

  void delete() {
    final equation = state.equation;

    if (equation.isNotEmpty) {
      final newEquation = equation.substring(0, equation.length - 1);

      if (newEquation.isEmpty) {
        reset();
      } else {
        state = state.copy(equation: newEquation);
        calculate();
      }
    }
  }

  void reset() {
    final equation = '0';
    final result = '0';

    state = state.copy(equation: equation, result: result);
  }

  void resetResult() {
    final equation = state.result;
    state = state.copy(
      equation: equation,
      shouldAppend: false,
    );
  }

  void append(String buttonText) {
    final equation = () {
      if (state.equation.length <= 14) {
        // 記号のとき
        if (Utils.isOperator(buttonText) &&
            Utils.isOperatorAtEnd(state.equation)) {
          final newEquation =
              state.equation.substring(0, state.equation.length - 1);
          return newEquation + buttonText;
          //追加する必要があるとき
        } else if (state.shouldAppend) {
          return state.equation == '0'
              ? buttonText
              : state.equation + buttonText;
        } else {
          return Utils.isOperator(buttonText)
              ? state.equation + buttonText
              : buttonText;
        }
      }
    }();

    state = state.copy(equation: equation, shouldAppend: true);
    calculate();
  }

  void equals() {
    calculate();
    resetResult();
  }

  void calculate() {
    //正しいコマンドに置き換え
    final expression = state.equation.replaceAll('⨯', '*').replaceAll('÷', '/');

    try {
      final exp = Parser().parse(expression);
      final model = ContextModel();

      final result = '${exp.evaluate(EvaluationType.REAL, model)}';
      state = state.copy(result: result);
      //最後に計算符号がある時に計算しない
    } catch (e) {}
  }
}
