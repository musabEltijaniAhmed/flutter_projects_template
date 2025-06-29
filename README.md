
# 📦 flutter_projects_template

A clean, scalable, and production-ready **Flutter project template** designed to kickstart your mobile app development with best practices, modular architecture, and pre-integrated tools.

---

## 🚀 Features

- ✅ **Ready-to-scale structure** with clearly separated layers (Presentation, Application, Domain, Infrastructure)
- 🎯 **Supports Clean Architecture** and SOLID principles
- 🧱 Integrated with [`mason`](https://pub.dev/packages/mason) to be used as a reusable code generator
- 🔧 Pre-configured with:
  - `flutter_lints` for static analysis
  - Clean routing and navigation setup
  - Environment configuration support
  - Separation of concerns and testability
- ⚙️ Works seamlessly with **VS Code Extension** or CLI using `mason make`
- 🛠 Android: Package name & namespace automatically generated
- 🍏 iOS: Bundle identifier ready for dynamic injection

---

## 📁 Structure Overview

```
lib/
├── core/               # Common utilities and constants
├── features/           # Modular feature-first structure
│   └── home/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── main.dart
```

---

## 🧰 Usage (via Mason)

1. Add the brick:

```bash
mason add flutter_projects_template --path .
```

2. Generate your project:

```bash
mason make flutter_projects_template
```

3. Enter:
   - `project_name`
   - `package_name`
   - `description`

---

## 💡 Who is this for?

This template is perfect for:
- Mobile engineers who want a **production-grade starting point**
- Teams working with **feature-based modular Flutter apps**
- Developers looking to enforce **code separation and testability**

---

## 🤝 Contributions

Feel free to fork, contribute, or suggest improvements via pull requests or issues!
