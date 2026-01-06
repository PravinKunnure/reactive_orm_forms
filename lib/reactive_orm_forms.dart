/// Reactive ORM Forms
///
/// A Flutter form binding layer for `reactive_orm`.
///
/// This library provides reactive form widgets (text fields, checkboxes,
/// dropdowns, sliders, etc.) that automatically stay in sync with
/// `ReactiveModel` fields using symbol-based reactivity.
///
/// It is UI-focused, lightweight, and requires no controllers or providers.
library;

export 'src/reactive_form.dart';
export 'src/reactive_form_field.dart';

/// Form widgets
export 'src/widgets/reactive_text_field.dart';
export 'src/widgets/reactive_checkbox.dart';
export 'src/widgets/reactive_switch.dart';
export 'src/widgets/reactive_dropdown.dart';
export 'src/widgets/reactive_selector.dart';
export 'src/widgets/reactive_slider.dart';
export 'src/widgets/reactive_date_picker.dart';

/// Model extensions
export 'src/extensions/reactive_model_fields.dart';

/// Core reactive_orm exports
export 'package:reactive_orm/core/reactive_model.dart';
export 'package:reactive_orm/core/reactive_builder.dart';
