//
//  NetworkService.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import Foundation
import Moya

class NetworkService {
    
    static let shared = NetworkService()
    
    private let provider = MoyaProvider<MovieAPI>()
    
    func performRequest<T: Decodable>(_ target: MovieAPI,_ type: T.Type, onSuccess: @escaping (T) -> Void, onFailure: @escaping (String) -> Void) {
        
        if ConnectionService.isConnectedToNetwork() {
            requestData(target, type, onSuccess: onSuccess, onFailure: onFailure)
        } else {
            onFailure(Message.NO_CONNECTION_MESSAGE)
        }
    }
    
    private func requestData<T: Decodable>(
        _ target: MovieAPI,_ type: T.Type,
        onSuccess: @escaping (T) -> Void,
        onFailure: @escaping (String) -> Void){
            
            provider.request(target, callbackQueue: .global(qos: .background)) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        do {
                            try onSuccess(response.map(T.self))
                        } catch {
                            onFailure(error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        onFailure(error.localizedDescription)
                    }
                }
            }
        }
}
