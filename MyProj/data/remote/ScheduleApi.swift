//
//  ScheduleApi.swift
//  MyProj
//
//  Created by Patryk Wójcik on 01/03/2023.
//

import Alamofire
import Foundation
import XMLCoder

class ScheduleApi {
    private init() { }

    static func get<T: Decodable>(
        _ url: String
    ) async -> Result<T, NetworkError> {
        await AF.request(url)
            .serializingDecodable(T.self, decoder: XMLDecoder())
            .result
    }
}
