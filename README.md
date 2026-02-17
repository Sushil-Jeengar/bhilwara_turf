# Bhilwara Turf - Sports Turf Booking App

A complete Flutter mobile application for booking sports turfs in Bhilwara. This app allows users to discover, book, and manage sports facility reservations with a modern, premium UI.

## Features

### 🔐 Authentication
- Phone number/Email login with OTP verification
- User registration with profile management
- Persistent login state

### 🏠 Home Screen
- Hero section with app branding
- Search and filter functionality (Sport type, Date selection)
- Statistics display (Turfs listed, Happy players, Average rating)
- Popular turfs showcase

### 🏟️ Turf Management
- Browse available turfs with filters
- Detailed turf information with image galleries
- Real-time slot availability
- Interactive booking system
- Price and amenity details

### 🤝 Partnership Program
- Turf owner collaboration platform
- Partnership benefits showcase
- Contact form for new partnerships
- Success stories from existing partners

### 👤 User Profile
- Personal information management
- Booking history and status tracking
- Account settings and preferences
- Logout functionality

## Design & Theme

The app follows the exact design language of the website:
- **Dark theme** with green highlights (#2ECC71)
- **Modern UI** with rounded cards and soft shadows
- **Premium feel** with gradient backgrounds
- **Sports-focused** iconography and imagery
- **Responsive design** for different screen sizes

## Technical Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: StatefulWidget with setState
- **Local Storage**: SharedPreferences
- **UI Components**: Material Design with custom theming
- **Navigation**: Bottom Navigation Bar with 4 main screens

## App Structure

```
lib/
├── main.dart                 # App entry point
├── utils/
│   └── app_theme.dart       # Theme configuration
├── models/
│   └── turf_model.dart      # Data models
├── screens/
│   ├── splash_screen.dart   # Splash screen with animations
│   ├── auth/
│   │   ├── login_screen.dart    # Login with OTP
│   │   └── signup_screen.dart   # User registration
│   ├── main_navigation.dart     # Bottom navigation
│   ├── home/
│   │   └── home_screen.dart     # Home screen
│   ├── turf/
│   │   ├── turf_list_screen.dart    # Turf listing with filters
│   │   └── turf_details_screen.dart # Turf details and booking
│   ├── collab/
│   │   └── own_turf_screen.dart     # Partnership program
│   └── profile/
│       └── profile_screen.dart      # User profile and settings
```

## Key Features Implementation

### 🎨 UI/UX Design
- Matches website color palette and design language
- Smooth animations and transitions
- Professional, production-ready interface
- Dark theme optimized for sports apps

### 📱 Navigation Flow
1. **Splash Screen** → Authentication check
2. **Login/Signup** → OTP verification
3. **Main App** → 4-tab bottom navigation
4. **Booking Flow** → Turf selection → Details → Slot booking

### 🔧 Functionality
- Form validations for all user inputs
- Date and time slot selection
- Booking confirmation system
- Profile management
- Partnership inquiry system

## Installation & Setup

1. **Prerequisites**:
   - Flutter SDK (3.10.0+)
   - Dart SDK
   - Android Studio / VS Code

2. **Clone and Setup**:
   ```bash
   git clone <repository-url>
   cd bhilwara_turf
   flutter pub get
   ```

3. **Run the App**:
   ```bash
   flutter run
   ```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.2.2  # Local storage
  intl: ^0.19.0              # Date formatting
  flutter_rating_bar: ^4.0.1 # Rating display
  carousel_slider: ^5.0.0    # Image carousel
```

## App Flow

1. **Splash Screen** (3 seconds) → Check login status
2. **Authentication** → Login/Signup with OTP
3. **Home Screen** → Search turfs, view stats
4. **Turf List** → Browse and filter available turfs
5. **Turf Details** → View details, select slots, book
6. **Own Turf** → Partnership program and contact form
7. **Profile** → Manage account, view bookings, logout

## Data Models

### TurfModel
- Basic turf information (name, location, sports)
- Pricing and rating details
- Amenities and timings
- Booking availability

### BookingModel
- Booking details and status
- Date and time slot information
- Payment and confirmation data

## Future Enhancements

- Real backend integration
- Payment gateway integration
- Push notifications
- Google Maps integration
- Review and rating system
- Advanced search filters
- Social sharing features

## College Project Notes

This is a **final year college project** demonstrating:
- Complete mobile app development
- Modern UI/UX design principles
- Flutter framework proficiency
- State management and navigation
- Form handling and validation
- Local data persistence
- Professional code structure

The app uses dummy/static data for demonstration purposes but is structured to easily integrate with real backend services.

---

**Developed by**: [Your Name]  
**Project Type**: Final Year College Project  
**Framework**: Flutter  
**Platform**: Android (Primary), iOS Compatible
