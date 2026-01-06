import 'package:flutter/material.dart';
import 'package:reactive_orm_forms/reactive_orm_forms.dart';

/// A reactive switch widget bound to a [ReactiveModel] field.
///
/// [ReactiveSwitch] allows toggling a `bool` value in the given [model].
/// Changes in the model automatically update the switch, and user toggles
/// update the model field.
///
/// Example:
/// ```dart
/// final model = MyReactiveModel();
/// ReactiveSwitch(model: model, fieldName: 'isActive');
/// ```
class ReactiveSwitch extends ReactiveFormField<bool> {
  /// The reactive model that holds the boolean field.
  const ReactiveSwitch({
    required super.model,
    required super.fieldName,
    super.validator,
    super.key,
  });

  @override
  ReactiveSwitchState createState() => ReactiveSwitchState();
}

/// State for [ReactiveSwitch].
///
/// Listens to the reactive model field and rebuilds the switch whenever
/// the field value changes. Updates the model when the user toggles it.
class ReactiveSwitchState extends State<ReactiveSwitch> {
  /// Current value of the bound field from the model.
  bool get value => widget.model.getField(Symbol(widget.fieldName)) ?? false;

  /// Updates the model field with the new value.
  set value(bool val) => widget.model.setField(Symbol(widget.fieldName), val);

  /// Called when the model field changes to trigger a rebuild.
  void _onChange() => setState(() {});

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_onChange, field: Symbol(widget.fieldName));
  }

  @override
  void dispose() {
    widget.model.removeListener(_onChange, field: Symbol(widget.fieldName));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(value: value, onChanged: (v) => value = v);
  }
}
