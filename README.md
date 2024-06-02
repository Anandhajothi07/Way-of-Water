# Way of Water

Way of Water is an IoT-based automated irrigation app built using Flutter and Adafruit IO. The app allows users to monitor and control their irrigation system remotely, providing real-time data on weather conditions and sensor readings.

## Table of Contents
- [Overview](#overview)
- [File Descriptions](#file-descriptions)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

Way of Water is designed to simplify the process of managing an irrigation system. It provides a user-friendly interface to monitor weather conditions, sensor data, and control the pump state through integration with Adafruit IO.

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
- **Key Components**:
  - `SettingsPage`: Stateful widget that allows users to input and save their user name, location, and land area.
  - Text fields for user name, location, and land area with a save button.

### `StartPage.dart`
- **Purpose**: Initial page for entering user information and navigating to the settings or home page.
- **Key Components**:
  - `StartPage`: Stateful widget for user input and navigation.
  - Text fields for user name, location, and land area with buttons to navigate to the `SettingsPage` or `HomeScreen`.

### `WeatherPage.dart`
- **Purpose**: Displays weather data fetched from Adafruit IO.
- **Key Components**:
  - `AdafruitIOService`: Service class for fetching weather data.
  - `WeatherPage`: Stateful widget that fetches and displays weather data with icons representing different weather conditions.

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/way-of-water.git
   cd way-of-water
## Usage
- **Boot-Up Screen**: Starts with an animation and navigates to the home screen.
- **Home Screen**: Displays rain and moisture data fetched from Adafruit IO.
- **Sensor Layout Page**: Shows location, latitude, and longitude data.
- **Settings Page**: Allows configuring app settings.
- **Start Page**: Initial page for entering user information and navigation.
- **Weather Page**: Displays weather data including temperature, rain, pressure, wind speed, and location.

## Contributing
- Fork the repository.
- Create a new branch (git checkout -b feature-branch).
- Make your changes and commit them (git commit -m 'Add new feature').
- Push to the branch (git push origin feature-branch).
- Open a Pull Request.
## License
- This project is licensed under the MIT License - see the LICENSE file for details.
