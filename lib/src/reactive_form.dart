import 'package:flutter/material.dart';

/// A lightweight container for reactive form fields.
///
/// [ReactiveForm] is a simple layout widget that groups
/// multiple reactive form field widgets together.
///
/// It does **not** manage validation or submission itself.
/// Instead, it acts as a structural helper to organize
/// form-related widgets in a consistent way.
///
/// This widget is intentionally minimal to keep
/// `reactive_orm_forms` flexible and UI-agnostic.
class ReactiveForm extends StatelessWidget {
  /// Child widgets that make up the form.
  ///
  /// Typically contains multiple [ReactiveFormField]
  /// implementations such as text fields, checkboxes,
  /// switches, or dropdowns.
  final List<Widget> children;

  /// Creates a [ReactiveForm] widget.
  ///
  /// The [children] parameter defines the visual
  /// structure of the form.
  const ReactiveForm({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: children);
  }
}
