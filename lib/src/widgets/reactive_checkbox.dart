import 'package:flutter/material.dart';
import 'package:reactive_orm_forms/reactive_orm_forms.dart';

/// A reactive checkbox form field bound to a [ReactiveModel].
///
/// [ReactiveCheckbox] automatically syncs its checked state
/// with a boolean field inside a reactive model.
///
/// When the underlying model field changes, the checkbox
/// rebuilds automatically. When the user toggles the checkbox,
/// the model field is updated.
class ReactiveCheckbox extends ReactiveFormField<bool> {
  /// Creates a reactive checkbox bound to a model field.
  ///
  /// - [model] is the reactive model holding the state
  /// - [fieldName] is the name of the boolean field inside the model
  /// - [validator] is an optional validation function
  const ReactiveCheckbox({
    required super.model,
    required super.fieldName,
    super.validator,
    super.key,
  });

  @override
  ReactiveCheckboxState createState() => ReactiveCheckboxState();
}

/// State for [ReactiveCheckbox].
///
/// Listens to changes in the bound model field and
/// triggers UI rebuilds when the value changes.
class ReactiveCheckboxState extends State<ReactiveCheckbox> {
  /// Current boolean value from the reactive model.
  bool get value => widget.model.getField(Symbol(widget.fieldName)) ?? false;

  /// Updates the boolean value in the reactive model.
  set value(bool val) => widget.model.setField(Symbol(widget.fieldName), val);

  @override
  void initState() {
    super.initState();

    // Listen only to the specific field for efficient rebuilds
    widget.model.addListener(_onChange, field: Symbol(widget.fieldName));
  }

  /// Called when the bound model field changes.
  void _onChange() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.model.removeListener(_onChange, field: Symbol(widget.fieldName));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: value, onChanged: (v) => value = v!);
  }
}
