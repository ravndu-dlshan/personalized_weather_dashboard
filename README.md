# 🌦️ Personalized Weather Dashboard

A simple Flutter application that generates weather information using coordinates derived from a **student index number**. The app fetches live weather data from the **Open-Meteo API**, displays it with a clean UI, and supports offline viewing through local caching.

---

## 🚀 Features

* 🔢 Convert student index → latitude & longitude
* 🌍 Fetch real-time weather from **Open-Meteo**
* 💾 Offline caching using `shared_preferences`
* 📡 Shows API request URL for transparency
* 🎨 Clean Material 3 UI with cards and icons
* 📱 Fully mobile‑responsive Flutter interface
* 🔁 Auto-loads previously cached weather data

---

## 🧮 Coordinate Formula

Coordinates are computed from the **first four digits** of the index:

```
firstTwo  = int(index[0:2])
nextTwo   = int(index[2:4])
latitude  = 5 + (firstTwo / 10.0)
longitude = 79 + (nextTwo / 10.0)
```

Example for index **224258B**:

* Latitude = 7.20°
* Longitude = 83.20°

---

## 🖼️ Screenshots

(Add screenshots here — example code:)

```
![App Screenshot](screenshots/app.png)
```

---

## 📡 API Request Example

```
https://api.open-meteo.com/v1/forecast?latitude=7.2&longitude=83.2&current_weather=true
```

---

## 📁 Project Structure

```
lib/
 ├── models/
 │    ├── coordinates.dart
 │    └── weather_data.dart
 ├── services/
 │    ├── weather_service.dart
 │    └── cache_service.dart
 ├── widgets/
 │    ├── coordinates_card.dart
 │    ├── weather_info_card.dart
 │    └── url_display.dart
 └── main.dart
```

---

## 📦 Installation & Setup

1. Install Flutter SDK
2. Clone this repository:

```
git clone <repo-url>
```

3. Install dependencies:

```
flutter pub get
```

4. Run the application:

```
flutter run
```

---

## 💡 How It Works

1. User enters student index
2. App computes coordinates using formula
3. WeatherService builds the API request URL
4. Data is fetched and displayed in `WeatherInfoCard`
5. CacheService saves the response for offline use

---


