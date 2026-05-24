//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import UIKit
import MapKit

class HikeDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView?
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var notesLabel: UILabel!

    var appDelegate: AppDelegate?
    var myDataManager: DataManager?

    func connectModel() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myDataManager = self.appDelegate?.myDataManager
    }

    func setupDefaultMap() {
        mapView?.delegate = self

        let defaultLocation = CLLocationCoordinate2D(latitude: 39.1653, longitude: -86.5264)
        let region = MKCoordinateRegion(center: defaultLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)

        mapView?.setRegion(region, animated: false)
    }

    func showRouteMap(for hike: Hike) {
        mapView?.delegate = self

        if let overlays = mapView?.overlays {
            mapView?.removeOverlays(overlays)
        }

        var coordinates: [CLLocationCoordinate2D] = []

        for point in hike.route {
            let coordinate = CLLocationCoordinate2D(
                latitude: point.latitude,
                longitude: point.longitude
            )

            coordinates.append(coordinate)
        }

        if coordinates.count > 1 {
            let routeLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
            mapView?.addOverlay(routeLine)

            let padding = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)

            mapView?.setVisibleMapRect(
                routeLine.boundingMapRect,
                edgePadding: padding,
                animated: false
            )
        } else if let firstPoint = hike.route.first {
            let location = CLLocationCoordinate2D(
                latitude: firstPoint.latitude,
                longitude: firstPoint.longitude
            )

            let region = MKCoordinateRegion(
                center: location,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )

            mapView?.setRegion(region, animated: false)
        } else {
            setupDefaultMap()
        }
    }

    func loadHikeDetails() {
        connectModel()

        if let hike = myDataManager?.getCurrentHike() {
            titleLabel.text = hike.title
            dateLabel.text = hike.dateText
            distanceLabel.text = "Distance: \(hike.distanceText)"
            durationLabel.text = "Duration: \(hike.durationText)"
            notesLabel.text = "Notes: \(hike.notes)"

            showRouteMap(for: hike)
        } else {
            titleLabel.text = "No Hike Selected"
            dateLabel.text = ""
            distanceLabel.text = ""
            durationLabel.text = ""
            notesLabel.text = ""

            setupDefaultMap()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaultMap()
        loadHikeDetails()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadHikeDetails()
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let line = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: line)
            renderer.strokeColor = UIColor.systemBlue
            renderer.lineWidth = 4
            return renderer
        }

        return MKOverlayRenderer()
    }
}
