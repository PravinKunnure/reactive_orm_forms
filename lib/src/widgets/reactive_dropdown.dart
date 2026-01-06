import 'package:flutter/material.dart';
import 'package:reactive_orm_forms/reactive_orm_forms.dart';

/// A reactive dropdown field bound to a [ReactiveModel] property.
///
/// [ReactiveDropdown] synchronizes its selected value directly
/// with a field inside a reactive model. Any change to the model
/// updates the UI, and user selections automatically update
/// the model.
///
/// This widget supports generic value types via `<T>`.
class ReactiveDropdown<T> extends ReactiveFormField<T> {
  /// The dropdown menu items to display.
  final List<DropdownMenuItem<T>> items;

  /// Optional hint text shown when no value is selected.
  final String? hint;

  /// Creates a reactive dropdown bound to a model field.
  const ReactiveDropdown({
    required super.model,
    required super.fieldName,
    required this.items,
    this.hint,
    super.validator,
    super.key,
  });

  @override
  ReactiveDropdownState<T> createState() => ReactiveDropdownState<T>();
}

/// State for [ReactiveDropdown].
///
/// Listens to changes in the bound model field and triggers
/// widget rebuilds when the value updates.
class ReactiveDropdownState<T> extends State<ReactiveDropdown<T>> {
  /// Current selected value from the reactive model.
  T? get value => widget.model.getField(Symbol(widget.fieldName));

  /// Updates the selected value in the reactive model.
  set value(T? val) => widget.model.setField(Symbol(widget.fieldName), val);

  @override
  void initState() {
    super.initState();

    // Listen only to the specific field for efficient updates
    widget.model.addListener(_onChange, field: Symbol(widget.fieldName));
  }

  /// Triggers a rebuild when the model field changes.
  void _onChange() => setState(() {});

  @override
  void dispose() {
    widget.model.removeListener(_onChange, field: Symbol(widget.fieldName));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      hint: widget.hint != null ? Text(widget.hint!) : null,
      items: widget.items,
      onChanged: (v) => value = v,
    );
  }
}
