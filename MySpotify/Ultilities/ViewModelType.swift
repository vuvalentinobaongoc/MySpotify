//
//  ViewModelType.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 04/04/2022.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
