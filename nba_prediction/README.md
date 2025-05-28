# NBA Prediction App

A Flutter mobile application designed for getting an overview of NBA games with AI predictions and detailed statistics.

[![Main screen demo](https://i.postimg.cc/HWbwmDMb/image.png)](https://postimg.cc/ThYLjsCP)

[![Game details demo](https://i.postimg.cc/P5Sb7Wwc/image.png)](https://postimg.cc/WdJJFJS6)

## Features

- **Live Game Data**: Real-time updates for ongoing games
- **Predictive Analytics**: Win probability calculations using Machine Learning models
- **Dark/Light Theme**: Automatic system theme detection with manual override
- **Game Details**: Comprehensive stats including:
  - Team performance metrics
  - Head-to-head comparisons
  - Recent game history
- **Responsive Design**: Optimized for mobile devices

## Technical Highlights

- **Modern Architecture**: Clean architecture with MVVM pattern
- **API Integration**: RESTful API communication with error handling
- **State Management**: Provider for theme and data management
- **Animations**: Hero animations for smooth transitions
- **Adaptive UI**: Responsive layout for various screen sizes

## Development

### Prerequisites
- Flutter 3.7+
- Dart 2.19+
- iOS/Android development environment

### Installation
```bash
git clone https://github.com/yourusername/nba-prediction-app.git
cd nba-prediction-app
flutter pub get
flutter run