//
//  Result+Moya.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import Foundation
import Moya

extension Result where Success == Response {
    /// Returns a new result, decode any success value (as a `Response`) using the given decoder to a value of the type you specify.
    /// - Parameters:
    ///   - newSuccess: The type of the new success value.
    ///   - decoder: An object that decodes instances of a data type from JSON objects.
    /// - Returns: A new result with the success value is the specified type, if the decoder can parse the data.
    public func decode<NewSuccess: Decodable>(
        as newSuccess: NewSuccess.Type = NewSuccess.self,
        using decoder: JSONDecoder = JSONDecoder()
    ) -> Result<NewSuccess, Error> {
        mapError { (failure: Failure) in
            failure as Error
        }
        .flatMap { (success: Response) in
            Result<NewSuccess, Error> {
                try decoder.decode(newSuccess, from: success.data)
            }
        }
    }
}

extension Result where Failure == MoyaError {
    /// Returns a new result, decode any data in the response of the failure value (as `MoyaError`) using the given decoder to a value of the type you specify.
    /// - Parameters:
    ///   - newFailure: The type of the new failure value.
    ///   - decoder: An object that decodes instances of a data type from JSON objects.
    /// - Returns: A new result with the success value is the specified type, if the decoder can parse the data.
    public func decodeError<NewFailure: Decodable & Error>(
        as newFailure: NewFailure.Type = NewFailure.self,
        using decoder: JSONDecoder = JSONDecoder()
    ) -> Result<Success, Error> {
        mapError { (failure: MoyaError) -> Error in
            (failure.response?.data).flatMap {
                try? JSONDecoder().decode(NewFailure.self, from: $0)
            } ?? failure
        }
    }
}
