# walk-yourself-like-a-dog
A dog-themed fitness tracker app made with Fluter

<img width="300" alt="image" src="https://github.com/user-attachments/assets/2b739658-1327-4b8e-af8d-e6407bd98678" />

## Running the POC

```
flutter create . --project-name walk_yourself_like_a_dog
flutter pub get
flutter run
```

Add location permissions after generating the platform folders:

- Android (`android/app/src/main/AndroidManifest.xml`): `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` and `INTERNET`.
- iOS (`ios/Runner/Info.plist`): `NSLocationWhenInUseUsageDescription`.

## Building and running the application for web

```
flutter build web
cd .\build\web\
python -m http.server 8000
```

## Install flutter

<https://docs.flutter.dev/install/quick>

Now navigate to `http://localhost:8000/`
