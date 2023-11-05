class TaskField {
  final int id;
  final String label;
  final bool isRequired;
  final String fieldType;

  TaskField(
      {required this.id,
      required this.label,
      required this.isRequired,
      required this.fieldType});
}
