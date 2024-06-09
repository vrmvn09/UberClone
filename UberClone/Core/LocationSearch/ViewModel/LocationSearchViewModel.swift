//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Arman  Urstem on 08.06.2024.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    //MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?
    
    private var searchCompleter = MKLocalSearchCompleter()
    var quereFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = quereFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    //MARK: - Lifecycle
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = quereFragment
    }
    
    //MARK: - Helpers
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Error searching for location \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            print("DEBUG: Location coordinates \(coordinate)")
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
        }
    
    func computeRidePrice(forType type: RideType) -> Double {
        guard let destCoordinate = selectedUberLocation?.coordinate else { return 0.0}
        guard let userCoordinate = self.userLocation else { return 0.0}
        
        let userlocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        
        let destintion = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userlocation.distance(from: destintion)
        
        return type.computePrice(for: tripDistanceInMeters)
    }
    
    func getDestinationRoute(from userlocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userlocation)
        let destPlacmark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacmark)
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("DEBUG: Error calculating route \(error.localizedDescription)")
                return
            }
                
            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickupAndDropoffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
