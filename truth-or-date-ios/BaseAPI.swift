//
//  BaseAPI.swift
//  ios-training
//
//  Created by Quang Nguyễn Như on 17/05/2023.
//

import Foundation

class BaseAPI {
    static let share = BaseAPI()
    
    func fetchData<M: Decodable>(urlString: String,
                                 method: HTTPMethod = .get,
                                 parameters: [String: Any] = [:],
                                 responseType: M.Type,
                                 completionHandler: @escaping (Result<M, ServiceError>)-> Void) {
        
        guard var components = URLComponents(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        if method == HTTPMethod.get {
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: "\(value)")
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        
        guard let url = components.url else {
            completionHandler(.failure(.urlError))
            return
        }
        
        // Create request
        let request = self.generateRequest(url: url, method: method.rawValue)
        
        if method == HTTPMethod.post {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        }
        URLCache.shared.removeAllCachedResponses()
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest,
                                                  completionHandler: { data, response, error in
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    let errorMessage = error?.localizedDescription ?? "Server Error"
                    completionHandler(.failure(ServiceError.init(issueCode: .initValue(value: errorMessage))))
                    return
                }
                
                guard let existData = data, let httpResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(ServiceError.notFoundData))
                    return
                }
                
                guard (try? JSONSerialization.jsonObject(with: existData, options: [])) != nil else {
                    completionHandler(.failure(.jsonError))
                    return
                }
                
                guard self.isSuccess(httpResponse.statusCode) else {
                    guard let error = self.getFailedServiceError(existData) else {
                        completionHandler(.failure(.parseError))
                        return
                    }
                    completionHandler(.failure(error))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseObj = try decoder.decode(M.self, from: existData)
                    completionHandler(.success(responseObj))
                } catch {
                    completionHandler(.failure(.parseError))
                }
            }
        })
        
        dataTask.resume()
    }
    
    
    func getFailedServiceError(_ data: Data?) -> ServiceError? {
        guard let data = data,
              let responseObj = try? JSONDecoder().decode(Issue.self, from: data) else {
            return nil
        }
        var messError: String = responseObj.error ?? ""
        
        if let errorFields = responseObj.error {
            messError = errorFields
        }
        
        if let errorCode = responseObj.errorCode, !errorCode.isEmpty {
            messError = errorCode
        }
        
        return ServiceError(issueCode: IssueCode.initValue(value: messError))
    }
    
    func isSuccess(_ code: Int) -> Bool {
        switch code {
        case 200...304:
            return true
        default:
            return false
        }
    }
    
    private func generateRequest(url: URL, method: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpBody = nil
        return request
    }
}

