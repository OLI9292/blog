---
title: "Introduction to MapKit and Core Location"
date: 2017-03-02 00:00
---
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;One of the reasons I love iOS development, is that users more accepting about using applications that track their physical data.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you want to use maps and GPS you will need to import two frameworks: [MapKit](https://developer.apple.com/reference/mapkit) and [Core Location](https://developer.apple.com/reference/corelocation).

**MapKit**

- display map imagery in your views

- annotate your map with points of interest

**Core Location**

- track the position of a users’ devices

- interact with beacons

**<center>* * * * *</center>**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In the following file, the `MapController` class that inherits from `UIView`. The corresponding view contains a `MKMapView`, which is our map. In the same class an instance of `CLLocationManager` is created. To track the current position of the user it is necessary to call `requestWhenInUseAuthorization()` and to call `startUpdatingLocation()` to notify our class with `CLLocation` data.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Location data must be received via the `locationManager()` function, which is a stream of data containing all the tracked locations in an array, since the `locationManager` was created.
<br><br>

```swift
import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, MKMapViewDelegate {

  @IBOutlet weak var map: MKMapView!
  let locationManager = CLLocationManager()

  override func viewDidLoad() {
    setUpMapView()
    setupLocationTracking()
  }

  func setUpMapView() {
    map.delegate = self
    map.showsUserLocation = true
    map.mapType = .satellite
  }
}


private typealias LocationManager = MapController
extension LocationManager: CLLocationManagerDelegate {

  func setupLocationTracking() {
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last.map({ Location(location: $0) }) else { return }
    map.setRegion(location.region, animated: false)
  }
}
```
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`CLLocation` data is cool, because it contains a lot more information than just latitude and longitude. For example, it provides altitude, speed, direction, radius of uncertainty, it can even tell you the logical floor of the building in which the user is located.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For the purpose of the example, the objective is just to update the map, so the user sees his / her current position on the map. From the `locationManager()` data stream, the most recent location is mapped into an instance of Location.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Interestingly, `MapKit` possesses a similar method to `locationManager()`. `mapView(_:didUpdate:)` notifies the delegate when the location of the user was updated. A major difference is that this method is not called if the application is running in the background, whereas Core Location’s does.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The map location is set, and the view updated, through the `setRegion()` method of `MKMapView`, which accepts a `MKCoordinateRegion`. Location is abstracted into the following struct.
<br><br>

```swift
struct Location {
    
    let location: CLLocation
    let span = MKCoordinateSpanMake(0.05, 0.05)

    var latitude: CLLocationDegrees {
        return location.coordinate.latitude
    }
    
    var longitude: CLLocationDegrees {
        return location.coordinate.longitude
    }
    
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    var region: MKCoordinateRegion {
        return MKCoordinateRegionMake(coordinates, span)
    }
}
```
<br>

**Result**
<center>![](/images/monkey-face.png)</center>
<center>Russia</center>
<center>65.476721, -173.511416</center>

**<center>* * * * *</center>**

**Conclusion**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MapKit and Core Location can be a feature of your app, or the key component. Some of the most popular apps on the App Store: Uber, Waze, Yelp, Pokemon Go, rely entirely on these frameworks.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;An interesting thing to monitor will be the increasing adoption of iBeacons and apps that utilize their data. Beacons are more versatile than Core Location’s geographical region monitoring, because they are mobile and provide greater accuracy in terms of distance to a specific point. In a world of IoT, one can easily imagine the power of an application that smartly analyzes it’s physical environment.

