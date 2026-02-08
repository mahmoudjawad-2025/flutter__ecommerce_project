class Validators {
  static String? notEmpty(String? value) =>
      (value == null || value.isEmpty) ? 'Required' : null;
}
