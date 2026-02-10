//
//  NetworkService.swift
//  Hooligans
//
//  Created by 정명곤 on 2023/09/14.
//

import Combine
import Foundation
import UIKit

// MARK: - NetworkError

public enum NetworkError: Error {
  case invalidRequest
  case unknownError(message: String)
}

// MARK: - HTTPMethod

public enum HTTPMethod: String {
  case get
  case post
  case put
  case patch
  case delete
}

// MARK: - NetworkService

public final class NetworkService {

  // MARK: Internal

  static let shared = NetworkService()

  func buildEndpoint(baseURL: String, _ endpoint: String) -> URL {
    guard let url = URL(string: baseURL + endpoint) else { return URL(string: "")! }

    return url
  }

  // MARK: Private

  private let baseURL = "http://13.124.61.192:8080"

}

extension NetworkService {
  func get(to endpoint: Endpoint) -> URLSession.DataTaskPublisher {
    let url = buildEndpoint(baseURL: baseURL, endpoint.endpoint)

    let request = RequestBuilder()
      .url(url: url)
      .method(.get)
      .header()
      .create()

    return URLSession(configuration: .default).dataTaskPublisher(for: request)
  }

  func post(to endpoint: Endpoint, param: [String: Any]) -> URLSession.DataTaskPublisher {
    let url = buildEndpoint(baseURL: baseURL, endpoint.endpoint)

    let request = RequestBuilder()
      .url(url: url)
      .method(.post)
      .body(param)
      .header()
      .create()

    return URLSession(configuration: .default).dataTaskPublisher(for: request)
  }

  func post(to endpoint: String, param: [String: Any]) -> URLSession.DataTaskPublisher {
    let url = buildEndpoint(baseURL: baseURL, endpoint)

    let request = RequestBuilder()
      .url(url: url)
      .method(.post)
      .body(param)
      .header()
      .create()

    return URLSession(configuration: .default).dataTaskPublisher(for: request)
  }

  func put() { }
}
