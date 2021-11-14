//
//  Router.swift
//  Employees
//
//  Created by Anton Stremovskiy on 07.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?

    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                guard let respond = response as? HTTPURLResponse else {
                    return
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode == -1001 {
                }
                
                
                if let response = response as? HTTPURLResponse, response.statusCode == 403 || response.statusCode == 401 {
                    #if DEBUG
                    print("Emergency exit status code" + "\(response.statusCode)")
                    #endif
                }
                
                if !(200...299).contains(respond.statusCode), let data = data {
                    if let responseString = String(bytes: data, encoding: .utf8) {
                        print(responseString)
                        completion(nil, nil, responseString)
                    }
                }
                completion(data, response, error?.localizedDescription)
            })
            task?.resume()
        } catch {
            completion(nil, nil, error.localizedDescription)
        }
    }
    
    func cancel() {
        task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 60)
        
        request.httpMethod = route.method.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let urlParameters,
                                              let additionHeaders):
                
                self.addAdditionalHeaders(additionHeaders as? HTTPHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestMultipartFormDataParametersAndHeaders(bodyParameters: let bodyParameters,
                                                      urlParameters: let urlParameters,
                                                      additionHeaders: let additionHeaders,
                                                      images: let images):
                
                try self.configreMultipartFormDataParameters(bodyParameters: bodyParameters,
                                                     urlParameters: urlParameters,
                                                     images: images,
                                                     request: &request)
                
                self.addAdditionalHeaders(additionHeaders as? HTTPHeaders, request: &request)
                
            case .requestBodyParametersAndHeaders(bodyParameters: let bodyParameters,
                                                  additionHeaders: let additionHeaders):
                
                self.addAdditionalHeaders(additionHeaders as? HTTPHeaders, request: &request)
                try self.configureBodyParameters(bodyParameters: bodyParameters,
                                                 request: &request)
            }

            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    private func configureBodyParameters(bodyParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: [bodyParameters])
            }
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private lazy var boundary: String = {
        return "Boundary-\(UUID().uuidString)"
    }()
    
    private func configreMultipartFormDataParameters(bodyParameters: Parameters?,
                                             urlParameters: Parameters?,
                                             images: [UIImage]?,
                                             request: inout URLRequest) throws {
        
        let boundaryPrefix = "--\(boundary)\r\n"
        let mimeType = "image/jpeg"
        var body = Data()
        
        do {
            if let bodyParameters = bodyParameters {
                for (key, value) in bodyParameters {
                    body.append(string: boundaryPrefix)
                    body.append(string: "Content-Disposition: form-data; name=\"\(key)\"; charset=utf-8")
                    body.append(string: "\r\n\r\n\(value)\r\n")
                }
            }
            
            if let imageArray = images {
                
                var dataArray = [Data]()
                for (_, image) in imageArray.enumerated() {
                    if let data = image.jpegData(compressionQuality: 0.3) {
                        dataArray.append(data)
                    }
                }
                
                var filename = String()
                for (index, data) in dataArray.enumerated(){
                    filename = "image\(index)"
                    body.append(string: boundaryPrefix)
                    body.append(string: "Content-Disposition: form-data; name=\"img[id1]\"; filename=\"\(filename)\"\r\n")
                    body.append(string: "Content-Type: \(mimeType)\r\n\r\n")
                    body.append(data)
                    body.append(string: "\r\n")
                }
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
            
            body.append(string: "--\(boundary)--\r\n")
            
            request.httpBody = body
            request.setValue("multipart/form-data; boundary=\(boundary); charset=utf-8", forHTTPHeaderField: "Content-Type")
            
        } catch {
            throw error
        }
        
    }
}

