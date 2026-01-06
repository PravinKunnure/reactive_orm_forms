import 'package:flutter/material.dart';
import 'package:reactive_orm/reactive_orm.dart';

/// Signature for a form field validator.
///
/// Takes the current field value of type [T] and returns:
/// - `null` if the value is valid
/// - a [String] error message if validation fails
typedef Validator<T> = String? Function(T value);

/// Base class for all reactive form fields.
///
/// [ReactiveFormField] connects a Flutter form widget to a
/// [ReactiveModel] field using a symbolic field name.
///
/// It provides:
/// - Automatic UI updates when the bound model field changes
/// - Optional validation via a [Validator]
/// - A shared contract for all reactive form widgets
///
/// Concrete implementations should extend this class and
/// implement the widget-specific UI and interaction logic.
abstract class ReactiveFormField<T> extends StatefulWidget {
  /// The reactive model that owns the form field.
  ///
  /// Changes to the associated model field will automatically
  /// trigger UI updates.
  final ReactiveModel model;

  /// The name of the field in the model.
  ///
  /// This value is used to identify which model property
  /// the form field is bound to.
  final String fieldName;

  /// Optional validator for the form field value.
  ///
  /// If provided, the validator is executed to determine
  /// whether the current value is valid.
  final Validator<T>? validator;

  /// Creates a reactive form field bound to a [ReactiveModel].
  ///
  /// All subclasses must supply a [model] and a [fieldName].
  /// Validation can be added by providing a [validator].
  const ReactiveFormField({
    required this.model,
    required this.fieldName,
    this.validator,
    super.key,
  });
}
