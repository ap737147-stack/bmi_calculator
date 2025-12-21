# 💪 BMI Calculator App

A beautiful and modern Flutter application for calculating Body Mass Index (BMI) with an elegant user interface and smooth animations.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## ✨ Features

- **Beautiful UI Design** - Modern gradient backgrounds with smooth animations
- **Real-time Validation** - Input fields validate as you type with visual feedback
- **BLoC Architecture** - Clean, scalable state management using flutter_bloc
- **Instant Calculation** - Calculate BMI based on weight (kg) and height (feet & inches)
- **Health Categories** - Get categorized results: Underweight, Normal, Overweight, or Obese
- **Color-coded Results** - Visual indicators with appropriate colors for each BMI category
- **Smooth Animations** - Fade-in effects and loading states for better UX
- **Elegant Snackbars** - Beautiful success and error notifications
- **Reset Functionality** - Quick reset button to clear all inputs

## 🎨 BMI Categories

| BMI Range | Category | Color |
|-----------|----------|-------|
| < 18.5 | Underweight | Blue |
| 18.5 - 24.9 | Normal Weight | Green |
| 25.0 - 29.9 | Overweight | Orange |
| ≥ 30.0 | Obese | Red |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code with Flutter extensions
- An Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/bmi-calculator.git
   cd bmi-calculator
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── main.dart                 # App entry point
├── bmi_calculator.dart       # Main calculator UI
└── bloc/
    ├── auth_bloc.dart        # Business logic & state management
    ├── auth_event.dart       # Event definitions
    └── auth_state.dart       # State definitions

assets/
└── alok.jpg                  # Background image (optional)
```

## 🏗️ Architecture

This app follows the **BLoC (Business Logic Component)** pattern for state management:

- **Events**: User actions (weight changed, calculate BMI, reset)
- **States**: App states (form state, success, loading, error)
- **BLoC**: Handles events and emits states

### Key Components

#### Events
- `WeightChanged` - Triggered when weight input changes
- `Feetchanged` - Triggered when feet input changes
- `Inchchanged` - Triggered when inches input changes
- `CalculateBmi` - Triggered when calculate button is pressed
- `ResetBmi` - Triggered when reset button is pressed

#### States
- `AuthFormState` - Manages form inputs, validation, and BMI result
- `Authinitial` - Initial state when app starts

## 🎯 How to Use

1. **Enter Your Weight** - Input your weight in kilograms
2. **Enter Your Height** - Input your height in feet and inches
3. **Calculate** - Press the "Calculate BMI" button
4. **View Results** - See your BMI value with category and health advice
5. **Reset** - Use the refresh button to start over

## 🔧 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  cupertino_icons: ^1.0.2
```

## 📝 Code Highlights

### BMI Calculation Formula
```dart
BMI = weight (kg) / [height (m)]²

// Convert feet & inches to meters
heightInInches = (feet × 12) + inches
heightInMeters = heightInInches × 0.0254
bmi = weight / (heightInMeters × heightInMeters)
```

### Input Validation
- Weight must be a positive number
- Feet must be a positive integer
- Inches must be between 0-11

## 🎨 Customization

### Colors
You can customize the color scheme by modifying the gradient colors in `bmi_calculator.dart`:

```dart
gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Colors.blue.shade400,
    Colors.purple.shade300,
    Colors.pink.shade300,
  ],
),
```

### Background Image
Replace `assets/alok.jpg` with your own background image or remove it for a pure gradient background.

## 🐛 Known Issues

- None currently reported

## 🔮 Future Enhancements

- [ ] Add metric/imperial unit toggle
- [ ] Save BMI history
- [ ] Add BMI tracking charts
- [ ] Multi-language support
- [ ] Dark mode support
- [ ] Export BMI reports
- [ ] Add weight goals feature

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**
- GitHub: [@ap737147-stack](https://github.com/ap737147-stack)
- Email: ap737147@gmail.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- flutter_bloc package for state management
- Material Design for UI inspiration

## 📞 Support

If you have any questions or need help, feel free to:
- Open an issue
- Contact me via email
- Submit a pull request

---

Made with ❤️ using Flutter

**⭐ If you like this project, please give it a star on GitHub! ⭐**
