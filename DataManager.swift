//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import Foundation

class DataManager: Codable {

    var theCurrentHikeIndex = 0
    var theHikes: [Hike] = []

    init() {
    }

    func numberOfHikes() -> Int {
        return theHikes.count
    }

    func hike(at index: Int) -> Hike? {
        if index < 0 {
            return nil
        }

        if index >= theHikes.count {
            return nil
        }

        return theHikes[index]
    }

    func addHike(_ hike: Hike) {
        theHikes.append(hike)
        theCurrentHikeIndex = theHikes.count - 1
    }

    func deleteHike(at index: Int) {
        if index < 0 {
            return
        }

        if index >= theHikes.count {
            return
        }

        theHikes.remove(at: index)

        if theCurrentHikeIndex >= theHikes.count {
            theCurrentHikeIndex = theHikes.count - 1
        }

        if theCurrentHikeIndex < 0 {
            theCurrentHikeIndex = 0
        }
    }

    func setCurrentIndex(_ index: Int) {
        if index < 0 {
            return
        }

        if index >= theHikes.count {
            return
        }

        theCurrentHikeIndex = index
    }

    func getCurrentHike() -> Hike? {
        if theHikes.count == 0 {
            return nil
        }

        if theCurrentHikeIndex < 0 {
            return nil
        }

        if theCurrentHikeIndex >= theHikes.count {
            return nil
        }

        return theHikes[theCurrentHikeIndex]
    }
}
