import Alamofire

typealias NetworkResult<T> = Result<T, NetworkError>

typealias NetworkError = AFError
