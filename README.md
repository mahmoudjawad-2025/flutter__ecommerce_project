<div align="left">

# 🛍️ E-Commerce App (Flutter)

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![Status](https://img.shields.io/badge/Status-In%20Development-orange)]()
[![License](https://img.shields.io/badge/License-MIT-green)]()

### A responsive, multi-language E-Commerce application.

> [!WARNING]
> 🚧 **Status: Experimental.** This project is in an early-stage phase. It is not recommended for production use as features are currently being refined and the codebase remains unstable.

</div>

<br>
<hr>

## 📋 Table of Contents
- [🌟 Overview](#-overview)
- [✨ Key Features](#-key-features)
- [🌍 Internationalization](#-internationalization)
- [📦 Tech Stack](#-tech-stack)
- [🏁 Getting Started](#-getting-started)
- [📞 Contact](#-contact)

<br>
<hr>

## 🌟 Overview

This project showcases a modern, scalable architecture for building cross-platform E-Commerce applications. While the current focus is on establishing a functional baseline, the development roadmap is designed to evolve toward a Clean Architecture to ensure long-term scalability, supporting a global audience through **global localization**, and a seamless experience across **all device types**.


<br>
<hr>

## ✨ Key Features (Implemented & Planned)

### 📱 Adaptive & Responsive UI
Designed to look stunning on any screen size.
- **Mobile First**: Optimized touch targets and layouts.
- **Tablet Ready**: Adapts to larger screens with multi-column layouts.
- **Desktop Friendly**: Full-width utilization for web and desktop platforms.
- **Tech**: Utilizes `flutter_screenutil` and `device_preview` for pixel-perfect scaling.

### 🌍 Internationalization (i18n)
Built for a global audience with full RTL support.
- **Languages**: English 🇺🇸 / Arabic 🇸🇦
- **Seamless Switching**: Instant language toggle without restarting the app.
- **Tech**: Powered by `flutter_localizations` and `provider`.

### 🛠️ Architecture & State Management
- **Pattern**: Feature-first, clean architecture.
- **State Management**: 
  - `flutter_bloc` for complex business logic.
  - `provider` for simple global state (Theme/Locale).
- **Navigation**: robust routing with `go_router`.


<br>
<hr>


## 📦 Tech Stack & Packages

| Category | Package | Description |
|----------|---------|-------------|
| **Core** | `flutter`, `dart` | The UI toolkit |
| **State** | `flutter_bloc` | Predictable state management |
| **DI** | `get_it` | Service locator for decoupling |
| **Routing** | `go_router` | Declarative routing solution |
| **UI** | `flutter_screenutil` | Screen adaptation |
| **Localization** | `flutter_localizations` | Multi-language support |
| **Network** | `dio` / `cached_network_image` | API calls & Image caching |
| **Testing** | `device_preview` | Preview on different devices |


<br>
<hr>


<br>
<hr>

## 🏁 Getting Started

To explore the current state of the project:

1. **Clone the repo**
   ```bash
   git clone <repo-url>
   ```
2. **Install dependencies**
   ```bash
   cd ecommerce_app
   flutter pub get
   ```
3. **Run the app**
   ```bash
   flutter run
   ```

<br>
<hr>


<div align="center">
  <sub> </sub>
</div>

## 📞 Contact

- 📧 **Email**: [mahmoudjawad02025@gmail.com](mailto:mahmoudjawad02025@gmail.com)
- 💻 **GitHub Profile**: [@mahmoudjawad-2025](https://github.com/mahmoudjawad-2025/)
- 💼 **LinkedIn:** [linkedin.com/in/mahmoud-abu-alsebaa](https://linkedin.com/in/mahmoud-abu-alsebaa)
