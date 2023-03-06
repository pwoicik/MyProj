//
//  NetworkError.swift
//  MyProj
//
//  Created by Patryk Wójcik on 01/03/2023.
//

import Alamofire

typealias NetworkResult<T> = Result<T, NetworkError>

typealias NetworkError = AFError
