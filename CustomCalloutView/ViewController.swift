//
//  ViewController.swift
//  CustomCalloutView
//
//  Created by Malek T. on 3/9/16.
//  Copyright © 2016 Medigarage Studios LTD. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var coordinates: [[Double]]!
    var names:[String]!
    var addresses:[String]!
    var phones:[String]!
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        coordinates = [[48.85672,2.35501],[48.85196,2.33944],[48.85376,2.33953]]// Latitude,Longitude
        names = ["Coffee Shop · Rue de Rivoli","Cafe · Boulevard Saint-Germain","Coffee Shop · Rue Saint-André des Arts"]
        addresses = ["46 Rue de Rivoli, 75004 Paris, France","91 Boulevard Saint-Germain, 75006 Paris, France","62 Rue Saint-André des Arts, 75006 Paris, France"]
        phones = ["+33144789478","+33146345268","+33146340672"]
        self.mapView.delegate = self
        // 2
        for i in 0...2
        {
            let coordinate = coordinates[i]
            let point = StarbucksAnnotation(coordinate: CLLocationCoordinate2D(latitude: coordinate[0] , longitude: coordinate[1]))
//            point.image = UIImage(named: "starbucks-\(i+1).jpg")
//            point.name = names[i]
//            point.address = addresses[i]
            
//            self.addRadiusCircle(location: CLLocation(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude))
           
//            point.phone = phones[i]
            self.mapView.addAnnotation(point)
        }
        // 3
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.856614, longitude: 2.3522219000000177), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.mapView.setRegion(region, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRadiusCircle(location: CLLocation){
        self.mapView.delegate = self
        let circle = MKCircle(center: location.coordinate, radius: 1000)
        self.mapView.add(circle)
    }
    
    @objc func calloutViewButtonClicked(_ sender: UIButton) {
        print(sender.tag)
    }
    // MARK - Action Handler
//    @objc func callPhoneNumber(sender: UIButton)
//    {
//        let v = sender.superview as! CustomCalloutView
//        if let url = URL(string: "telprompt://\(v.starbucksPhone.text!)"), UIApplication.shared.canOpenURL(url)
//        {
//            UIApplication.shared.openURL(url)
//        }
//    }
}
typealias MapViewDelegate = ViewController
extension MapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "jobPlusIcon")
        return annotationView
    }
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        // 2
//        let starbucksAnnotation = view.annotation as! StarbucksAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
//        calloutView.starbucksName.text = starbucksAnnotation.name
//        calloutView.starbucksAddress.text = starbucksAnnotation.address
//        calloutView.starbucksPhone.text = starbucksAnnotation.phone
//        calloutView.starbucksImage.image = starbucksAnnotation.image
//        let button = UIButton(frame: calloutView.starbucksPhone.frame)
//        button.addTarget(self, action: #selector(ViewController.callPhoneNumber(sender:)), for: .touchUpInside)
//        calloutView.addSubview(button)
        // 3
        calloutView.center = CGPoint(x: (view.bounds.size.width/2)-5, y: (-calloutView.bounds.size.height*0.01)+15)
        calloutView.leftBottomButton.setImage(#imageLiteral(resourceName: "starbucks"), for: .normal)
        calloutView.leftBottomButton.addTarget(self, action: #selector(calloutViewButtonClicked(_:)), for: .touchUpInside)
        calloutView.topCenterButton.setImage(#imageLiteral(resourceName: "starbucks"), for: .normal)
        calloutView.topCenterButton.addTarget(self, action: #selector(calloutViewButtonClicked(_:)), for: .touchUpInside)
        calloutView.leftCenterButton.setImage(#imageLiteral(resourceName: "starbucks"), for: .normal)
        calloutView.leftCenterButton.addTarget(self, action: #selector(calloutViewButtonClicked(_:)), for: .touchUpInside)
        calloutView.rightCenterButton.setImage(#imageLiteral(resourceName: "starbucks"), for: .normal)
        calloutView.rightCenterButton.addTarget(self, action: #selector(calloutViewButtonClicked(_:)), for: .touchUpInside)
        calloutView.rightBottomButton.setImage(#imageLiteral(resourceName: "starbucks"), for: .normal)
        calloutView.rightBottomButton.addTarget(self, action: #selector(calloutViewButtonClicked(_:)), for: .touchUpInside)
//        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.center.y+30)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.red
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return MKPolylineRenderer()
        }
    }
}
