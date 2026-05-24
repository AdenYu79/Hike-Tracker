//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import Foundation
import UserNotifications

class NotificationManager {

    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
        }
    }

    static func sendHikeSavedNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hike Saved"
        content.body = "Your hike was saved successfully."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
}
