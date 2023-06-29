//
//  GeoLocationApiModel.swift
//  Swift Weather App
//
//  Created by Cameron on 6/25/23.
//

import Foundation

struct GeoLocationApiModel: Codable {
    let name: String;
    let lat: Float;
    let lon: Float;
    let country: String;
    let state: String;
}
