# crest_weather_demo

Flutter Weather mobile app that will show list of weather forecast of next 5 days according to your current location.

## Getting Started

Below libraries are used to develop this demo:

- [Dio](https://pub.dev/packages/dio) to make REST location api call using key query param with interceptor.
- In build json deserialization used to convert class fromJson and toJson.  
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc) for application state management.
- [Hydrated Bloc](https://pub.dev/packages/hydrated_bloc)  to store last record so that user can view last records even when offline.
- [Geolocator](https://pub.dev/packages/geolocator)  to get current location and fetch weather report for the location.
- Also added Widget Test and Unit Test samples for demo.
