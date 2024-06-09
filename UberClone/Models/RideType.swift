//
//  RideType.swift
//  UberClone
//
//  Created by Arman  Urstem on 09.06.2024.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberx
    case black
    case uberXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .uberx: return "UberX"
        case .black: return "UberBlack"
        case .uberXL: return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberx: return "uber-x"
        case .black: return "uber-black"
        case .uberXL: return "uber-x"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .uberx: return 5
        case .black: return 20
        case .uberXL: return 10
        }
    }
    
    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        
        switch self {
        case .uberx: return distanceInMiles * 1.5 + baseFare
        case .black: return distanceInMiles * 2.0 + baseFare
        case .uberXL: return distanceInMiles * 1.75 + baseFare
        }
    }
}
