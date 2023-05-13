//
//  Session.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import Foundation

enum SessionError: Error {
    case noData(HTTPURLResponse)
    case noResponse
    case unacceptableStatusCode(Int, Message?)
    case failedToCreateComponents(URL)
    case failedToCreateURL(URLComponents)
}

final class Session {
    private let accessToken: () -> AccessToken?
    private let additionalHeaderFields: () -> [String: String]?
    private let session: URLSession
    
    init(accessToken: @escaping () -> AccessToken? = { nil },
         additionalHeaderFields: @escaping () -> [String: String]? = { nil },
         session: URLSession = .shared) {
        self.accessToken = accessToken
        self.additionalHeaderFields = additionalHeaderFields
        self.session = session
    }
    
    func send<T: Request>(_ request: T) async throws -> T.Response? {
        let url = request.baseURL.appendingPathComponent(request.path)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw SessionError.failedToCreateComponents(url)
        }
        
        components.queryItems = request.queryParameters?.compactMap(URLQueryItem.init)
        
        guard var urlRequest = components.url.map({ URLRequest(url: $0) }) else {
            throw SessionError.failedToCreateURL(components)
        }
        
        urlRequest.httpMethod = request.method.rawValue
        
        let headerFields: [String: String]
        if let additionalHeaderFields = additionalHeaderFields() {
            headerFields = request.headerFields.merging(additionalHeaderFields, uniquingKeysWith: +)
        } else {
            headerFields = request.headerFields
        }
        
        if let token = accessToken() {
            let authorization = ["Authorization": "token \(token.accessToken)"]
            urlRequest.allHTTPHeaderFields = headerFields.merging(authorization, uniquingKeysWith: +)
        } else {
            urlRequest.allHTTPHeaderFields = headerFields
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else {
                throw SessionError.noResponse
            }
            
            guard  200..<300 ~= response.statusCode else {
                let message = try? JSONDecoder().decode(SessionError.Message.self, from: data)
                throw SessionError.unacceptableStatusCode(response.statusCode, message)
            }
                        
            return try JSONDecoder().decode(T.Response.self, from: data)
        } catch {
            throw error
        }
    }
}

extension SessionError {
    struct Message: Decodable {
        let documentationURL: URL
        let message: String
        
        private enum CodingKeys: String, CodingKey {
            case documentationURL = "documentation_url"
            case message
        }
    }
}
