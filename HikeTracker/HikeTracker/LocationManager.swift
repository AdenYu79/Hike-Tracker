//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()
    private var lastLocation: CLLocation?
    private var totalDistance = 0.0
    private var routePoints: [RoutePoint] = []
    private var isTracking = false

    var currentLocation: CLLocation?
    var locationUpdated: (() -> Void)?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5
    }

    func startTracking() {
        totalDistance = 0.0
        routePoints = []
        lastLocation = nil
        isTracking = true

        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func stopTracking() {
        isTracking = false
        manager.stopUpdatingLocation()
    }

    func getDistanceText(useMiles: Bool) -> String {
        if useMiles {
            let miles = totalDistance / 1609.34
            return String(format: "%.2f mi", miles)
        } else {
            let km = totalDistance / 1000.0
            return String(format: "%.2f km", km)
        }
    }

    func getRoute() -> [RoutePoint] {
        return routePoints
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !isTracking {
            return
        }

        if let newLocation = locations.last {
            currentLocation = newLocation

            if let previousLocation = lastLocation {
                totalDistance = totalDistance + newLocation.distance(from: previousLocation)
            }

            lastLocation = newLocation

            let timeText = DateFormatter.localizedString(
                from: Date(),
                dateStyle: .none,
                timeStyle: .medium
            )

            let point = RoutePoint(
                latitude: newLocation.coordinate.latitude,
                longitude: newLocation.coordinate.longitude,
                timestampText: timeText
            )

            routePoints.append(point)
            locationUpdated?()
        }
    }
}
