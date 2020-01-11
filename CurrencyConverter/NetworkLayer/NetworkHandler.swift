//
//  NetworkHandler.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkHandlerProtocol {
    func request(_ request: URLRequestConvertible, debug: Bool) -> Future<Data>
    func upload(files: [File]?, to request: URLRequestConvertible, debug: Bool) -> Future<Data>
    func download(url: URLConvertible) -> Future<URL?>
    func invalidateAllRequests()
}

class NetworkHandler: NetworkHandlerProtocol {
    
    @Inject private var manager: SessionManager
    
    private func verifyResponse(response: DataResponse<Data>) -> NetworkError? {
        if let _ = response.error, (response.error as NSError?)?.code == -999 {
            return .cancelled
        }

        if let _ = response.error, (response.error as NSError?)?.code == -1009 {
            return .noInternetConnection
        }

        guard let _ = response.data else {
            return .invalidData
        }

        if let response = response.response, case 500...511 = response.statusCode {
            return .internalServerError
        }

        if let response = response.response, response.statusCode == 401 {
            return .unauthorized
        }
        
        //Handle the errors generally from the API according to their defined structure
        if response.response?.statusCode == 200 {
            guard let jsonObject = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: AnyObject] else { return .internalServerError }
            if let success = jsonObject["success"] as? Bool, success == false {
                if let message = jsonObject["error"]?["info"] as? String {
                    return .unknownError(message)
                } else {
                    return .internalServerError
                }
            }
        }

        return nil
    }
    
    private func extractPaginationData(from response: DataResponse<Data>) -> NetworkError? {
        guard let _ = response.response?.allHeaderFields as? [String: String] else {
            return .internalServerError
        }

        return nil
    }
    
    func request(_ request: URLRequestConvertible, debug: Bool = false) -> Future<Data> {
        let promise = Promise<Data>()
        manager.request(request).validate().debugLog().responseData { [weak self] response in
            guard let self = self else { return }

            if debug {
                print(String(data: response.data ?? Data(), encoding: .utf8) ?? "")
            }

            if let error = self.verifyResponse(response: response) {
                promise.reject(with: error)
                return
            }

            if let error = self.extractPaginationData(from: response) {
                promise.reject(with: error)
                return
            }

            switch response.result {
            case .success(let data):
                promise.resolve(with: data)
            case .failure(let error):
                promise.reject(with: error)
            }
        }
        return promise
    }

    func upload(files: [File]?, to request: URLRequestConvertible, debug: Bool = false) -> Future<Data> {
        let promise = Promise<Data>()
        manager.upload(multipartFormData: { formData in

            if let files = files {
                files.forEach { file in
                    formData.append(file.data, withName: file.key, fileName: file.name, mimeType: file.mimeType.rawValue)
                }
            }

            if let parameters = request.parameters {
                parameters.forEach { k,v in
                    formData.append("\(v)".data(using: .utf8) ?? Data(), withName: k)
                }
            }

        }, with: request) { result in
            switch result {
            case .success(let upload, _, _):
                upload.validate().debugLog().responseData { [weak self] response in
                    guard let self = self else { return }
                    if debug {
                        print(String(data: response.data ?? Data(), encoding: .utf8) ?? "")
                    }

                    if let error = self.verifyResponse(response: response) {
                        promise.reject(with: error)
                        return
                    }

                    switch response.result {
                    case .success(let data):
                        promise.resolve(with: data)
                    case .failure(let error):
                        promise.reject(with: error)
                    }
                }
            case .failure(let error):
                promise.reject(with: error)
            }
        }

        return promise
    }

    func download(url: URLConvertible) -> Future<URL?> {
        let promise = Promise<URL?>()
        let destination =  DownloadRequest.suggestedDownloadDestination(
            for: .cachesDirectory,
            in: .userDomainMask,
            with: [.removePreviousFile]
        )

        manager.download(url, to: destination).validate().debugLog().responseData { response in
            switch response.result {
            case .success:
                promise.resolve(with: response.destinationURL)
            case .failure(let error):
                promise.reject(with: error)
            }
        }

        return promise
    }
    
    func invalidateAllRequests() {
        manager.session.getAllTasks { tasks in tasks.forEach { $0.cancel() } }
    }
}
