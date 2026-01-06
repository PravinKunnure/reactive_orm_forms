import 'package:flutter/material.dart';
import 'package:reactive_orm_forms/reactive_orm_forms.dart';

/// A reactive date picker bound to a [ReactiveModel] field.
///
/// [ReactiveDatePicker] displays a tappable input that opens
/// Flutter’s native date picker dialog. The selected date is
/// stored directly inside the provided reactive model.
///
/// Any external changes to the bound model field automatically
/// rebuild the widget.
class ReactiveDatePicker extends StatefulWidget {
  /// The reactive model holding the date value.
  final ReactiveModel model;

  /// The name of the field in the model that stores a [DateTime].
  final String fieldName;

  /// The earliest selectable date.
  final DateTime? firstDate;

  /// The latest selectable date.
  final DateTime? lastDate;

  /// Creates a reactive date picker bound to a model field.
  const ReactiveDatePicker({
    required this.model,
    required this.fieldName,
    this.firstDate,
    this.lastDate,
    super.key,
  });

  @override
  State<ReactiveDatePicker> createState() => _ReactiveDatePickerState();
}

/// State for [ReactiveDatePicker].
///
/// Listens to the bound model field and triggers UI updates
/// whenever the date value changes.
class _ReactiveDatePickerState extends State<ReactiveDatePicker> {
  /// Current [DateTime] value from the reactive model.
  DateTime? get modelValue =>
      widget.model.getField(Symbol(widget.fieldName)) as DateTime?;

  /// Updates the [DateTime] value in the reactive model.
  set modelValue(DateTime? value) =>
      widget.model.setField(Symbol(widget.fieldName), value);

  /// Called when the bound model field changes.
  void _onModelChange() {
    if (!mounted) return;
    setState(() {});
  }

  /// Opens the system date picker dialog and updates the model
  /// with the selected date.
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: modelValue ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (picked != null) modelValue = picked;
  }

  @override
  void initState() {
    super.initState();

    // Listen only to the specified field for efficient rebuilds
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
    return InkWell(
      onTap: _pickDate,
      child: InputDecorator(
        decoration: const InputDecoration(border: OutlineInputBorder()),
        child: Text(
          modelValue != null
              ? modelValue!.toLocal().toString().split(' ')[0]
              : 'Select Date',
        ),
      ),
    );
  }
}
