class TValidator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName қажет.';
    }
    return null;
  }
}
