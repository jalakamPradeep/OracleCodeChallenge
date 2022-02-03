//
//  NetworkManager.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import Foundation

import Foundation
import Combine

enum Endpoint: String {
    case items
    case details
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // Generic task serves both home and detail calls this return Combine
    func getData<T: Decodable>(baseUrl: String, endpoint: Endpoint, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            //Make sure the url is valid
            guard let self = self, let url = URL(string: baseUrl) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            //web service call to fetch data
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    //pattern matching operator to check if i have valid response
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())// will decode as per modal
                .receive(on: RunLoop.main) // makes sure the main thread is active
                .sink(receiveCompletion: { (completion) in
                    // create subscriber
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables) 
        }
    }
}

// Extensions to help the errors
enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
