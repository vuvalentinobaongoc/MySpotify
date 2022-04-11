//
//  DataError.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 11/04/2022.
//

import Foundation

enum DataError: Error {
    case network(_ errorMessage: String)
    case expiredToken
    case unknown
}
