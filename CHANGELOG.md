# Changelog

All notable changes to this project will be documented in this file.

This project follows **Semantic Versioning**.

---

## [1.2.0] - 2026-01-06
### Added
- Added **Dartdoc documentation** for all public API (widgets, extensions, helpers).
- Introduced **watchField()** and **watchComputed()** helpers for ergonomic UI bindings.
- Enhanced **ReactiveModelFields** extension with full doc comments.
- Full support for:
  - `ReactiveTextField`
  - `ReactiveCheckbox`
  - `ReactiveSwitch`
  - `ReactiveDropdown`
  - `ReactiveSelectorF`
  - `ReactiveSlider`
  - `ReactiveDatePicker`
- Reactive widgets now fully documented for pub.dev and IDE hints.
- Improved examples for all widgets demonstrating:
  - Field-wise reactivity
  - Object-wise reactivity
  - Computed fields

### Changed
- Internal code re-organization for easier maintainability.
- Minor refactor in state management logic to unify listener handling.

### Notes
- Requires `reactive_orm` >=1.2.0.
- Focused on **developer ergonomics** and **documentation coverage**.
- Ready for **pub.dev Dartdoc verification**.

---

## [1.0.1] - 2025-12-30
--Minor documents related changes.

## [1.0.0] - 2025-12-30
### Added
- Initial release of `reactive_orm_forms`.
- Form widgets:
    - `ReactiveTextField`
    - `ReactiveCheckbox`
    - `ReactiveSelectorF` (Dropdown)
    - `ReactiveDatePicker`
    - `ReactiveSlider`
- Full support for field-wise reactivity with `ReactiveModel`.
- `ReactiveBuilder` integration for reactive previews.
- Nested and shared models supported.
- Minimal boilerplate, designed for rapid form development.

### Notes
- Requires `reactive_orm` >=1.0.0.
- All widgets fully reactive to model changes.
- Designed for Flutter apps with reactive domain models.