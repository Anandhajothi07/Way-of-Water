# Automated-Irrigation-App
# My Flutter App

This is a Flutter application designed to interact with Adafruit IO for sensor data and control a pump. The app consists of several screens including a boot-up screen, home screen, sensor layout page, and settings page.

## Table of Contents
- [Overview](#overview)
- [File Descriptions](#file-descriptions)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

This Flutter app communicates with Adafruit IO to fetch sensor data and control a pump. It features a smooth animation on the boot-up screen, displays sensor data on various screens, and provides a settings page for app configurations.

## File Descriptions

### `bootup_screen.dart`
- **Purpose**: Displays a boot-up animation and navigates to the home screen.
- **Key Components**:
  - `MyApp`: Sets up the MaterialApp with `BootUpPage` as the home.
  - `BootUpPage`: Stateful widget with an animation that navigates to `HomeScreen` after completion.

### `HomePage.dart`
- **Purpose**: Main screen that fetches and displays rain and moisture data.
- **Key Components**:
  - `AdafruitIOService`: Service class for interacting with Adafruit IO.
  - `HomeScreen`: Stateful widget that uses `AdafruitIOService` to fetch data and display it.

### `SensorLayoutPage.dart`
- **Purpose**: Displays sensor data including location, latitude, and longitude.
- **Key Components**:
  - `AdafruitIOService`: Reused service class for fetching sensor data.
  - `SensorLayoutPage`: Stateful widget that fetches and displays sensor data.

### `SettingsPage.dart`
- **Purpose**: Provides a settings interface for the app.
- **Key Components**: (Details to be added after file analysis)

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
