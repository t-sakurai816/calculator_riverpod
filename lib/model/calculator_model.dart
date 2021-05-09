class CalculatorModel {
  final bool shouldAppend;
  final String equation;
  final String result;

  const CalculatorModel({
    this.shouldAppend = true,
    this.equation = '0',
    this.result = '0',
    });

  // const Calculator({
  //   this.shouldAppend = true,
  //   this.equation = '0',
  //   this.result = '0',
  // });

  CalculatorModel copy({
    bool? shouldAppend,
    String? equation,
    String? result,
  }) =>
      CalculatorModel(
        shouldAppend: shouldAppend ?? this.shouldAppend,
        equation: equation ?? this.equation,
        result: result ?? this.result,
      );

}
