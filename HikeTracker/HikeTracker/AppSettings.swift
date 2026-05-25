//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import Foundation

class AppSettings {

    static let useMilesKey = "use_miles"
    static let notificationsOnKey = "notifications_on"

    static func registerDefaults() {
        UserDefaults.standard.register(defaults: [
            useMilesKey: true,
            notificationsOnKey: false
        ])
    }

    static func useMiles() -> Bool {
        return UserDefaults.standard.bool(forKey: useMilesKey)
    }

    static func notificationsOn() -> Bool {
        return UserDefaults.standard.bool(forKey: notificationsOnKey)
    }
}
