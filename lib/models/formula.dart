class Formula {
  final String name;
  final String expression;
  final Map<String, String> variables;
  final List<String> specialCases;
  final String siUnit;

  Formula({required this.name, required this.expression, required this.variables, required this.specialCases, required this.siUnit});
}