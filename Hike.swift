//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import Foundation

struct Hike: Codable {
    var title: String
    var dateText: String
    var distanceText: String
    var durationText: String
    var notes: String
    var route: [RoutePoint]
}
