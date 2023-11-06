class TaskField {
  final int id;
  final String label;
  final bool isRequired;
  final String fieldType;
  bool? completed;
  bool? edited;
  String? value;

  TaskField({
    required this.id,
    required this.label,
    required this.isRequired,
    required this.fieldType,
    this.completed,
    this.edited,
    this.value,
  });

  bool get isMaskPrice => fieldType != 'text';
}
