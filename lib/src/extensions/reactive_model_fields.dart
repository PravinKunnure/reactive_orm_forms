import 'package:reactive_orm/reactive_orm.dart';

/// Extension on [ReactiveModel] to provide dynamic field access via [Symbol].
///
/// This allows reactive form fields to get and set model values dynamically
/// without needing explicit getters/setters for each field.
///
/// Example:
/// ```dart
/// final model = MyReactiveModel();
/// final value = model.getField(#username);
/// model.setField(#username, 'new value');
/// ```
extension ReactiveModelFields on ReactiveModel {
  /// Gets the value of the field identified by [field] symbol.
  ///
  /// Internally converts the symbol to a string and calls `toJson()`
  /// on the model to retrieve the current value.
  dynamic getField(Symbol field) {
    final name = _symbolToString(field);
    final json = (this as dynamic).toJson();
    return json[name];
  }

  /// Sets the value of the field identified by [field] symbol to [value].
  ///
  /// Internally converts the symbol to a string and calls `fromJson()`
  /// on the model to update the value, then notifies listeners.
  void setField(Symbol field, dynamic value) {
    final name = _symbolToString(field);
    (this as dynamic).fromJson({name: value});
    notifyListeners(field);
  }

  /// Helper method to convert a [Symbol] to a [String] representing the field name.
  String _symbolToString(Symbol s) =>
      s.toString().replaceAll('Symbol("', '').replaceAll('")', '');
}
