# walk-yourself-like-a-dog
A dog-themed fitness tracker app made with Fluter

## Running the POC

```
flutter create . --project-name walk_yourself_like_a_dog
flutter pub get
flutter run
```

Add location permissions after generating the platform folders:

- Android (`android/app/src/main/AndroidManifest.xml`): `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` and `INTERNET`.
- iOS (`ios/Runner/Info.plist`): `NSLocationWhenInUseUsageDescription`.
