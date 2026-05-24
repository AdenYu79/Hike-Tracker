//
// Team Members: Aden Yu (adenyu@iu.edu)
// App Name: HikeTracker
//

import UIKit
import MapKit

class HomeViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView?
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var notesTextField: UITextField!

    var appDelegate: AppDelegate?
    var myDataManager: DataManager?
    let hikeController = HikeController()

    var seconds = 0
    var timer: Timer?
    var hikeIsRunning = false

    func connectModel() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myDataManager = self.appDelegate?.myDataManager
    }

    func setupMap() {
        mapView?.delegate = self
        mapView?.showsUserLocation = true

        let defaultLocation = CLLocationCoordinate2D(latitude: 39.1653, longitude: -86.5264)
        let region = MKCoordinateRegion(center: defaultLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)

        mapView?.setRegion(region, animated: false)
    }

    @IBAction func startHikeTapped(_ sender: Any) {
        if hikeIsRunning {
            return
        }

        hikeIsRunning = true
        seconds = 0

        distanceLabel.text = "Distance: 0.0 mi"
        durationLabel.text = "Duration: 0 sec"

        if let overlays = mapView?.overlays {
            mapView?.removeOverlays(overlays)
        }

        hikeController.locationManager.locationUpdated = {
            self.updateMapAndDistance()
        }

        hikeController.startHike()

        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTime),
            userInfo: nil,
            repeats: true
        )
    }

    @IBAction func stopHikeTapped(_ sender: Any) {
        if !hikeIsRunning {
            return
        }

        connectModel()

        hikeIsRunning = false
        timer?.invalidate()

        let hikeNumber = (myDataManager?.numberOfHikes() ?? 0) + 1
        let notes = notesTextField.text ?? ""

        let hike = hikeController.stopHike(
            seconds: seconds,
            notes: notes,
            hikeNumber: hikeNumber
        )

        myDataManager?.addHike(hike)
        appDelegate?.saveModel()

        if AppSettings.notificationsOn() {
            NotificationManager.sendHikeSavedNotification()
        }

        notesTextField.text = ""
        distanceLabel.text = "Distance: 0.0 mi"
        durationLabel.text = "Duration: 0 sec"
    }

    @objc func updateTime() {
        seconds = seconds + 1
        durationLabel.text = "Duration: \(seconds) sec"

        distanceLabel.text = "Distance: \(hikeController.locationManager.getDistanceText(useMiles: AppSettings.useMiles()))"
    }

    func updateMapAndDistance() {
        distanceLabel.text = "Distance: \(hikeController.locationManager.getDistanceText(useMiles: AppSettings.useMiles()))"

        if let location = hikeController.locationManager.currentLocation {
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 500,
                longitudinalMeters: 500
            )

            mapView?.setRegion(region, animated: true)
        }

        drawCurrentRoute()
    }

    func drawCurrentRoute() {
        let route = hikeController.locationManager.getRoute()

        var coordinates: [CLLocationCoordinate2D] = []

        for point in route {
            let coordinate = CLLocationCoordinate2D(
                latitude: point.latitude,
                longitude: point.longitude
            )

            coordinates.append(coordinate)
        }

        if coordinates.count > 1 {
            if let overlays = mapView?.overlays {
                mapView?.removeOverlays(overlays)
            }

            let routeLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
            mapView?.addOverlay(routeLine)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        connectModel()
        setupMap()

        distanceLabel.text = "Distance: 0.0 mi"
        durationLabel.text = "Duration: 0 sec"
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
