![Alt text](https://www.themoviedb.org/assets/2/v4/logos/v2/blue_long_1-8ba2ac31f354005783fab473602c34c3f4fd207150182061e425d366e4f34596.svg "a title")

# Movies App

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=thepraide_mobile-challenge-app&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=thepraide_mobile-challenge-app)

The MoviesApp is an iOS app that use the [API](https://api.themoviedb.org) from the https://www.themoviedb.org.

### The UI/UX

For this project is basically a simple List or Grid view to show all the poster and titles for the movies with posibility to liked some of them.

Supports portrait and landscape orientation

| Light    | Dark |
| -------- | ------- |
| <img src="https://github.com/thepraide/mobile-challenge-app/blob/main/images/challenge_light.gif?raw=true" >  | <img src = "https://github.com/thepraide/mobile-challenge-app/blob/main/images/challenge_dark.gif?raw=true">   |

### Architecture

The architecture that was chosen to use was MVVM+R mainly because of the ease of creating modules with the help of the [SwiftUI](https://developer.apple.com/xcode/swiftui/) framework.\
Use cases were created for the domain layer and a network layer for API calls.

##### Modular Diagram
<img src="https://github.com/thepraide/mobile-challenge-app/blob/main/images/module-diagram.png" >

##### App Diagram
<img src = "https://github.com/thepraide/mobile-challenge-app/blob/main/images/app-diagram.png">
