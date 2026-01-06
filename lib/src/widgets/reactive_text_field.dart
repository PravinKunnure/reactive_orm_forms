import 'package:flutter/material.dart';
import 'package:reactive_orm_forms/reactive_orm_forms.dart';

/// A reactive text field bound to a [ReactiveModel] string field.
///
/// [ReactiveTextField] automatically listens to changes in the provided
/// [model] and [fieldName], updating the TextField when the model changes.
/// User edits also update the model in real time. Optional validation
/// can be provided via [validator].
///
/// Example:
/// ```dart
/// final model = MyReactiveModel();
/// ReactiveTextField(
///   model: model,
///   fieldName: 'username',
///   hintText: 'Enter username',
///   validator: (val) => val.isEmpty ? 'Required' : null,
/// );
/// ```
class ReactiveTextField extends ReactiveFormField<String> {
  /// Optional hint text displayed in the TextField.
  final String? hintText;

  /// Creates a reactive text field.
  const ReactiveTextField({
    required super.model,
    required super.fieldName,
    super.validator,
    this.hintText,
    super.key,
  });

  @override
  ReactiveTextFieldState createState() => ReactiveTextFieldState();
}

/// State for [ReactiveTextField].
///
/// Manages the [TextEditingController] and listens for model changes.
/// Updates the model whenever the user types and performs optional validation.
class ReactiveTextFieldState extends State<ReactiveTextField> {
  late TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.model.getField(Symbol(widget.fieldName)) ?? '',
    );

    // Listen to model changes for this field
    widget.model.addListener(_onModelChange, field: Symbol(widget.fieldName));

    // Update model whenever user types
    _controller.addListener(() {
      widget.model.setField(Symbol(widget.fieldName), _controller.text);
      _validate();
    });

    _validate();
  }

  /// Called when the model field changes; updates the controller text.
  void _onModelChange() {
    final modelValue = widget.model.getField(Symbol(widget.fieldName)) ?? '';
    if (_controller.text != modelValue) {
      _controller.text = modelValue;
    }
  }

  /// Validates the current field value using [validator], if provided.
  void _validate() {
    if (widget.validator != null) {
      setState(() {
        _error = widget.validator!(_controller.text);
      });
    }
  }

  @override
  void dispose() {
    widget.model.removeListener(
      _onModelChange,
      field: Symbol(widget.fieldName),
    );
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(hintText: widget.hintText, errorText: _error),
    );
  }
}
