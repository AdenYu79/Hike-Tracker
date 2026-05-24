# HikeTracker

HikeTracker is an iOS app for recording, saving, and reviewing hikes. The app allows users to start and stop a hike, track distance and route information, save hike records locally, and view saved hikes later.

## Team Members

- Aden Yu — adenyu@iu.edu

## App Features

- Start and stop a hike
- Track hike duration
- Track distance using Core Location
- Save hike records locally
- View saved hikes in a list
- View selected hike details
- Display route information on a map
- Use iOS Settings app for preferences
- Toggle miles/km setting
- Toggle saved-hike notifications

## Main Screens

### Home

The Home screen lets the user start and stop a hike. It shows the map, distance, duration, notes field, and Start/Stop buttons.

### Hike List

The Hike List screen displays all saved hikes in a table view. Each saved hike shows basic information such as date and distance.

### Hike Detail

The Hike Detail screen displays the selected hike’s title, date, distance, duration, notes, and route map.

## Settings

Settings are handled through the iOS Settings app using `Settings.bundle`.

Available settings:

- Use Miles
- Notifications

## Technologies Used

- Swift
- UIKit
- Storyboard
- Tab Bar Controller
- Table View Controller
- MapKit
- Core Location
- User Notifications
- Settings.bundle
- UserDefaults
- PropertyListEncoder / PropertyListDecoder

## Main Swift Files

- `AppDelegate.swift` — handles app startup and saving/loading data
- `AppSettings.swift` — reads Settings.bundle preferences
- `DataManager.swift` — stores saved hikes
- `Hike.swift` — model for one saved hike
- `RoutePoint.swift` — model for one route location point
- `HikeController.swift` — controls start/stop hike logic
- `LocationManager.swift` — handles Core Location tracking
- `HomeViewController.swift` — controls the Home screen
- `HikeListViewController.swift` — controls the saved hikes table
- `HikeDetailViewController.swift` — controls selected hike details and route map
- `NotificationManager.swift` — handles saved-hike notifications
- `SceneDelegate.swift` — handles scene lifecycle and saving when app enters background

## How to Run

1. Open the project in Xcode.
2. Select an iPhone 16 or iPhone 17 simulator.
3. Build and run the app.
4. Allow location permission when prompted.
5. Use the Home tab to start and stop a hike.
6. Open the Hike List tab to view saved hikes.
7. Tap a saved hike to view its details.

## Notes

Route drawing works best when the app receives multiple location updates. On the simulator, this may require simulated movement. On a real iPhone, walking with the app running should create route points normally.
