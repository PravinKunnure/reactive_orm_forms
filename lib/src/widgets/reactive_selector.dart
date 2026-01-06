import 'package:flutter/material.dart';
import 'package:reactive_orm_forms/reactive_orm_forms.dart';

/// A reactive dropdown selector bound to a field inside a [ReactiveModel].
///
/// [ReactiveSelectorF] allows selecting a value of type [T] from a predefined
/// list of items. The selected value is automatically synchronized with
/// the given reactive model field.
///
/// When the model field changes, the widget rebuilds automatically.
/// When the user selects a new value, the model field is updated.
class ReactiveSelectorF<T> extends StatefulWidget {
  /// The reactive model that holds the field value.
  final ReactiveModel model;

  /// The name of the field inside the model to bind to.
  ///
  /// This is converted internally into a [Symbol].
  final String fieldName;

  /// List of selectable items.
  final List<T> items;

  /// Optional label builder for displaying each item.
  ///
  /// If not provided, `toString()` is used.
  final String Function(T)? labelBuilder;

  /// Creates a reactive selector widget.
  const ReactiveSelectorF({
    required this.model,
    required this.fieldName,
    required this.items,
    this.labelBuilder,
    super.key,
  });

  @override
  State<ReactiveSelectorF<T>> createState() => _ReactiveSelectorFState<T>();
}

/// State for [ReactiveSelectorF].
///
/// Listens to changes in the bound model field and triggers UI updates
/// when the value changes.
class _ReactiveSelectorFState<T> extends State<ReactiveSelectorF<T>> {
  /// Current value stored in the reactive model.
  T? get modelValue => widget.model.getField(Symbol(widget.fieldName)) as T?;

  /// Updates the reactive model field with a new value.
  set modelValue(T? value) =>
      widget.model.setField(Symbol(widget.fieldName), value);

  /// Handles model updates by triggering a rebuild.
  void _onModelChange() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // Listen only to the specific field for efficient updates
    widget.model.addListener(_onModelChange, field: Symbol(widget.fieldName));
  }

  @override
  void dispose() {
    widget.model.removeListener(
      _onModelChange,
      field: Symbol(widget.fieldName),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: modelValue,
      isExpanded: true,
      items: widget.items
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(widget.labelBuilder?.call(e) ?? e.toString()),
            ),
          )
          .toList(),
      onChanged: (v) => modelValue = v,
    );
  }
}
