//
//  HTTPClient.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public final class HTTPClient {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func sendRequest<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T {
        // Build the request using RequestBuilder
        let request: URLRequest
        do {
            request = try RequestBuilder.buildRequest(from: endpoint)
        } catch {
            throw APIError.invalidURL
        }

        do {
            // Perform the network request
            let (data, response) = try await session.data(for: request)

            // Validate the response
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw APIError.requestFailed(
                    statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1,
                    data: data
                )
            }

            // Decode the response
            return try DecodingHelper.decode(responseType, from: data)
        } catch {
            // Handle network errors
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                throw APIError.networkUnavailable
            }
            throw APIError.unknown(error)
        }
    }
}
