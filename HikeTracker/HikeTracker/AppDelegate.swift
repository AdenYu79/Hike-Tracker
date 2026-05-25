//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var myDataManager = DataManager()
    private let saveFileName = "HikeTrackerModel.plist"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppSettings.registerDefaults()
        NotificationManager.requestPermission()
        loadModel()
        return true
    }

    private func modelFileURL() -> URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docs.appendingPathComponent(saveFileName)
    }

    func saveModel() {
        let url = modelFileURL()
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        if let data = try? encoder.encode(myDataManager) {
            try? data.write(to: url)
        }
    }

    func loadModel() {
        let url = modelFileURL()

        if let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()

            if let loaded = try? decoder.decode(DataManager.self, from: data) {
                myDataManager = loaded
            }
        }
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
