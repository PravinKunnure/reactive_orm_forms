# reactive_orm_forms

[![Pub Version](https://img.shields.io/pub/v/reactive_orm_forms)](https://pub.dev/packages/reactive_orm_forms) | [![License: MIT](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/licenses/MIT)

> Lightweight Flutter package for **reactive form widgets** powered by `reactive_orm`.  
> Provides **field-wise reactivity**, **computed/watch helpers**, and ready-to-use form controls.

---

## 🎬 Demo

![Reactive_ORM Form](https://raw.githubusercontent.com/PravinKunnure/reactive_orm_forms/main/example/assets/demorormforms.gif)

---

## ✨ Features

- ✅ Fully reactive form widgets for Flutter
- ✅ Works seamlessly with `ReactiveModel` from `reactive_orm`
- ✅ Field-wise updates for optimized UI performance
- ✅ Includes:
  - `ReactiveTextField` – Text input bound to a model field
  - `ReactiveCheckbox` – Boolean input
  - `ReactiveSwitch` – Toggle input
  - `ReactiveSelectorF` – Dropdown/selector
  - `ReactiveDropdown` – Generic dropdown
  - `ReactiveDatePicker` – Date input
  - `ReactiveSlider` – Slider input
- ✅ Supports **watchField()** and **watchComputed()** for ergonomic UI updates
- ✅ Nested and shared models supported
- ✅ Minimal boilerplate; integrates directly with your domain models

---

## 🚀 Getting Started

### Installation

```yaml
dependencies:
  reactive_orm_forms: <latest_version>
``` 

## 🧩Usage Example:

```
import 'package:flutter/material.dart';
import 'package:reactive_orm/reactive_orm.dart';
import 'package:reactive_orm_forms/reactive_orm_forms.dart';

class Task extends ReactiveModel {
  String _title;
  bool _completed = false;

  Task({required String title}) : _title = title;

  String get title => _title;
  set title(String value) {
    if (_title != value) {
      _title = value;
      notifyListeners(#title);
    }
  }

  bool get completed => _completed;
  set completed(bool value) {
    if (_completed != value) {
      _completed = value;
      notifyListeners(#completed);
    }
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  final Task task = Task(title: "Design UI");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reactive ORM Forms Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ReactiveTextField(
              model: task,
              fieldName: "title",
              hintText: "Task title",
            ),
            ReactiveCheckbox(model: task, fieldName: "completed"),
            ReactiveSwitch(model: task, fieldName: "completed"),
            ReactiveBuilder<Task>(
              model: task,
              fields: [#title, #completed],
              builder: (t) => Text("Title: ${t.title}, Completed: ${t.completed}"),
            ),
          ],
        ),
      ),
    );
  }
}
```


## 🔧 Widgets
- ReactiveTextField – Text input bound to a reactive model field
- ReactiveCheckbox – Boolean input
- ReactiveSwitch – Toggle input
- ReactiveSelectorF – Dropdown / selector
- ReactiveDropdown – Generic dropdown
- ReactiveDatePicker – Date selection
- ReactiveSlider – Slider input


## 🧠 How It Works
- Models extend ReactiveModel from reactive_orm.
- Form widgets automatically listen to field changes and rebuild accordingly.
- `watchField()` and `watchComputed()` allow fine-grained reactive UI updates.
- Nested models propagate changes upward automatically.
- Minimal boilerplate; declarative, ORM-style reactive forms.


## 📌 Summary
- `reactive_orm_forms` is ideal for building reactive Flutter forms with:
- Minimal boilerplate
- Fine-grained field-level reactivity
- Computed and watched UI updates
- Full support for nested and shared models 

### It fully leverages the power of reactive_orm to create reactive forms that scale with your application.


