//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import Foundation

class HikeController {

    let locationManager = LocationManager()

    func startHike() {
        locationManager.startTracking()
    }

    func stopHike(seconds: Int, notes: String, hikeNumber: Int) -> Hike {
        locationManager.stopTracking()

        let hike = Hike(
            title: "Hike \(hikeNumber)",
            dateText: getTodayText(),
            distanceText: locationManager.getDistanceText(useMiles: AppSettings.useMiles()),
            durationText: getDurationText(seconds: seconds),
            notes: notes,
            route: locationManager.getRoute()
        )

        return hike
    }

    private func getTodayText() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }

    private func getDurationText(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60

        if minutes == 0 {
            return "\(remainingSeconds) sec"
        }

        return "\(minutes) min \(remainingSeconds) sec"
    }
}
