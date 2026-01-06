import 'package:flutter/material.dart';
import 'package:reactive_orm_forms/reactive_orm_forms.dart';

/// A reactive slider widget bound to a [ReactiveModel] field.
///
/// [ReactiveSlider] allows selecting a `double` value between [min] and [max].
/// The selected value is automatically synchronized with the given reactive
/// model field. Changes in the model update the slider, and changes in the
/// slider update the model.
class ReactiveSlider extends StatefulWidget {
  /// The reactive model that holds the field value.
  final ReactiveModel model;

  /// The name of the field in [model] to bind to.
  ///
  /// Internally converted into a [Symbol] for reactivity.
  final String fieldName;

  /// Minimum value of the slider (default `0`).
  final double min;

  /// Maximum value of the slider (default `100`).
  final double max;

  /// Optional number of divisions for the slider.
  final int? divisions;

  /// Creates a reactive slider widget.
  const ReactiveSlider({
    required this.model,
    required this.fieldName,
    this.min = 0,
    this.max = 100,
    this.divisions,
    super.key,
  });

  @override
  State<ReactiveSlider> createState() => _ReactiveSliderState();
}

/// State for [ReactiveSlider].
///
/// Listens to the reactive model field and rebuilds the slider whenever the
/// field value changes. Updates the model when the user moves the slider.
class _ReactiveSliderState extends State<ReactiveSlider> {
  /// Current value stored in the reactive model.
  double get modelValue =>
      (widget.model.getField(Symbol(widget.fieldName)) as double?) ??
      widget.min;

  /// Updates the reactive model field with a new value.
  set modelValue(double val) =>
      widget.model.setField(Symbol(widget.fieldName), val);

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
    return Slider(
      value: modelValue,
      min: widget.min,
      max: widget.max,
      divisions: widget.divisions,
      label: modelValue.toStringAsFixed(1),
      onChanged: (v) => modelValue = v,
    );
  }
}
